defmodule Dopple.Schedule.Event do
  use GenStage
  alias Dopple.Schedule

  @enforce_keys [:stage]
  defstruct     [:stage, id: UUID.uuid4]

  def new() do
    {:ok, pid} = start_link()
    %__MODULE__{stage: pid}
  end

  def start_link() do
    GenStage.start_link(__MODULE__, [])
  end

  def init(_args) do
    {:producer, {:queue.new(), 0}}
  end

  def enqueue(schedule, event) do
    GenServer.cast(schedule.stage, {:enqueue, event})
  end

  def handle_cast({:enqueue, event}, {queue, demand}) do
    case demand do
      0 -> {:noreply, [], {:queue.in(event, queue), demand}}
      _ -> {:noreply, [event], {queue, demand - 1}}
    end
  end

  def handle_demand(incoming, {queue, demand}) do
    {events, queue} = Enum.reduce(0..incoming, {[], queue}, fn _, {events, queue} ->
      case :queue.out(queue) do
        {{:value, val}, new_queue} -> {events ++ [val], new_queue}
        {:empty, _} -> {events, queue}
      end
    end)

    unsatisfied = incoming - Enum.count(events)
    {:noreply, events, {queue, demand + unsatisfied}}
  end

  defimpl Schedule, for: __MODULE__ do
    def producer(s), do: {:ok, s.stage}
  end
end
