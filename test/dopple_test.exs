defmodule DoppleTest do
  use ExUnit.Case
  doctest Dopple
  alias Dopple.{Measurement, Aggregator, Schedule, Target}

  test "can handle basic event schedule" do
    m = Measurement.Property.new(:status)
    schedule = Schedule.Event.new()
    target = Target.Http.new(:GET, "http://localhost:8080/status")
    test_pid = self()
    agg = Aggregator.Callback.new(fn evt -> send(test_pid, evt) end)

    with {:ok, m} <- Measurement.add_schedule(m, schedule),
         {:ok, m} <- Measurement.add_target(m, target),
         {:ok, m} <- Aggregator.add_measurement(agg, m) do
      schedule |> Schedule.Event.enqueue({:test, "This is a test"})
      :timer.sleep(500)
    end

    assert_received {:error, %HTTPoison.Error{id: nil, reason: :econnrefused}}
  end
end
