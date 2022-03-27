defmodule DoppleTest do
  use ExUnit.Case
  doctest Dopple
  alias Dopple.{Measurement, Aggregator, Schedule, Target}

  test "can handle basic event schedule" do
    measurement = Measurement.Property.new(:status)

    schedule = Schedule.Event.new()
    {:ok, measurement} = Measurement.add_schedule(measurement, schedule)

    target = Target.Http.new(:GET, "http://localhost:8080/status")
    {:ok, measurement} = Measurement.add_target(measurement, target)

    schedule |> Schedule.Event.enqueue({:test, "This is a test"})

    test_pid = self()
    agg = Aggregator.Callback.new(fn evt ->
      send(test_pid, evt)
    end)

    {:ok, agg} = Aggregator.add_measurement(agg, measurement)
    :timer.sleep(500)
    assert_received {:error, %HTTPoison.Error{id: nil, reason: :econnrefused}}

  end
end
