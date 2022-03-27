defmodule Dopple.Measurement.Property do
  @moduledoc """
    A measurement that retrieves a property of a response object
  """
  use GenStage
  alias Dopple.{Receipt, Schedule, Target}

  @enforce_keys [:stage]
  defstruct [:stage, schedules: [], targets: [], id: UUID.uuid4()]
  @type t() :: %__MODULE__{stage: GenStage.stage()}

  def new(property) do
    {:ok, pid} = start_link(property)
    %__MODULE__{stage: pid}
  end

  def start_link(property) do
    GenStage.start_link(__MODULE__, property)
  end

  def init(property) do
    {:producer_consumer,
     %{
       property: property,
       targets: []
     }}
  end

  def handle_cast({:target, target}, %{targets: targets} = state) do
    {:noreply, [], %{state | targets: [target | targets]}}
  end

  def handle_events(events, _from, %{targets: targets, property: prop} = state) do
    event_targets = Enum.zip(events, targets)

    responses =
      event_targets
      |> Enum.map(fn {event, target} ->
        case Target.respond_to(target, event) do
          {:ok, receipt} -> Map.fetch(Receipt.payload(receipt), prop)
          {:error, err} -> {:error, err}
        end
      end)

    {:noreply, responses, state}
  end
end

defimpl Dopple.Measurement, for: Dopple.Measurement.Property do
  alias Dopple.Schedule

  def add_schedule(m, schedule) do
    {:ok, producer} = Schedule.producer(schedule)

    case GenStage.sync_subscribe(m.stage, to: producer) do
      {:ok, _} -> {:ok, %{m | schedules: [schedule | m.schedules]}}
      {:error, err} -> {:error, err}
    end
  end

  def add_target(m, target) do
    GenServer.cast(m.stage, {:target, target})
    {:ok, %{m | targets: [target | m.targets]}}
  end

  def producer(m), do: {:ok, m.stage}
end
