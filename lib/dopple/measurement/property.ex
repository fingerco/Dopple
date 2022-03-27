defmodule Dopple.Measurement.Property do
  use GenStage
  alias Dopple.{Schedule, Target, Receipt, Measurement}

  @enforce_keys [:stage]
  defstruct     [:stage, schedules: [], targets: [], id: UUID.uuid4]

  def new(property) do
    {:ok, pid} = start_link(property)
    %__MODULE__{stage: pid}
  end

  def start_link(property) do
    GenStage.start_link(__MODULE__, property)
  end

  def init(property) do
    {:producer_consumer, %{
      property: property,
      targets: []
    }}
  end

  def handle_cast({:target, target}, %{targets: targets} = state) do
    {:noreply, [], %{state | targets: [target | targets]}}
  end

  def handle_events(events, _from, %{targets: targets, property: prop} = state) do
    responses = Enum.flat_map(events, fn event ->
      targets |> Enum.map(fn target ->
        case Target.respond_to(target, event) do
          {:ok, receipt} -> {:ok, Map.fetch!(Receipt.payload(receipt), prop)}
          {:error, err} -> {:error, err}
        end
      end)
    end)

    {:noreply, responses, state}
  end

  defimpl Measurement, for: __MODULE__ do
    def add_schedule(m, schedule) do
      {:ok, producer} = Schedule.producer(schedule)
      GenStage.sync_subscribe(m.stage, to: producer)

      {:ok, %{m | schedules: [schedule | m.schedules]}}
    end

    def add_target(m, target) do
      GenServer.cast(m.stage, {:target, target})

      {:ok, %{m | targets: [target | m.targets]}}
    end

    def producer(m), do: {:ok, m.stage}
  end
end
