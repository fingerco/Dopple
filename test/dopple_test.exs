defmodule DoppleTest do
  use ExUnit.Case
  doctest Dopple
  alias Dopple.{Aggregator, Measurement, Schedule, Target}

  test "can handle basic event schedule" do
    m = Measurement.Property.new(:status)
    schedule = Schedule.Event.new()
    target = Target.Http.new(:GET, "http://localhost:8080/status")
    test_pid = self()
    agg = Aggregator.Callback.new(fn evt -> send(test_pid, evt) end)

    with {:ok, m} <- Measurement.add_schedule(m, schedule),
         {:ok, _} <- Measurement.add_target(m, target),
         {:ok, _} <- Aggregator.add_measurement(agg, m) do
      schedule |> Schedule.Event.enqueue({:test, "This is a test"})
      :timer.sleep(500)
    end

    assert_received {:ok, _receipt}
  end
end
