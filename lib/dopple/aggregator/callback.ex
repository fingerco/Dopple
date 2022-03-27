defmodule Dopple.Aggregator.Callback do
  @moduledoc """
    An aggregator that takes the results of a measurement and performs a callback function on them
  """

  use GenStage
  alias Dopple.{Measurement}

  @enforce_keys [:stage]
  defstruct [:stage, measurements: []]

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
    events
    |> Enum.each(fn evt ->
      on_resp.(evt)
    end)

    {:noreply, [], on_resp}
  end
end

defimpl Dopple.Aggregator, for: Dopple.Aggregator.Callback do
  alias Dopple.Measurement

  def add_measurement(agg, m) do
    with {:ok, producer} <- Measurement.producer(m),
         {:ok, _} <- GenStage.sync_subscribe(agg.stage, to: producer) do
      {:ok, %{agg | measurements: [m | agg.measurements]}}
    end
  end

  def consumer(agg), do: {:ok, agg.stage}
end
