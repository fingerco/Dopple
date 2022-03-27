defmodule Dopple.Aggregator.Callback do
  use GenStage
  alias Dopple.{Measurement, Aggregator}

  @enforce_keys [:stage]
  defstruct     [:stage, measurements: []]

  def new(on_resp) do
    {:ok, pid} = start_link(on_resp)
    %__MODULE__{stage: pid}
  end

  def start_link(on_resp) do
    GenStage.start_link(__MODULE__, on_resp)
  end

  def init(on_resp) do
    {:consumer, on_resp}
  end

  def handle_events(events, _from, on_resp) do
    events |> Enum.each(fn evt ->
      on_resp.(evt)
    end)

    {:noreply, [], on_resp}
  end

  defimpl Aggregator, for: __MODULE__ do
    def add_measurement(agg, m) do
      {:ok, producer} = Measurement.producer(m)
      GenStage.sync_subscribe(agg.stage, to: producer)

      {:ok, %{agg | measurements: [m | agg.measurements]}}
    end

    def consumer(agg), do: {:ok, agg.stage}
  end
end
