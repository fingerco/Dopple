defmodule Dopple.PingTracking do
  defstruct [:target, :schedule]
  alias Dopple.Protocols.Target
  alias Dopple.Protocols.Schedule

  @spec tracker(for: Target.t, schedule: Schedule.t) :: PingTracking.t
  def tracker(for: target, schedule: schedule) do
    tracker = %__MODULE__{target: target, schedule: schedule}
    schedule |> Schedule.apply_to(tracker)
    tracker
  end
end
