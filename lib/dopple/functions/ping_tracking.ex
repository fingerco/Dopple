defmodule Dopple.PingTracking do
  defstruct [:target, :schedule]
  alias Dopple.Protocols.Schedule

  def tracker(for: target, schedule: schedule) do
    tracker = %__MODULE__{target: target, schedule: schedule}
    schedule |> Schedule.apply_to(tracker)
    tracker
  end
end
