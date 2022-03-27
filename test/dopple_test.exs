defmodule DoppleTest do
  use ExUnit.Case
  doctest Dopple
  alias Dopple.Protocols.Measurement
  alias Dopple.Protocols.Aggregator

  test "can handle basic event schedule" do
    measurement = Dopple.Measurements.PropertyMeasurement.new(:status)

    schedule = Dopple.Schedules.EventSchedule.new()
    {:ok, measurement} = Measurement.add_schedule(measurement, schedule)

    target = Dopple.Targets.HttpTarget.new(:GET, "http://localhost:8080/status")
    {:ok, measurement} = Measurement.add_target(measurement, target)

    schedule |> Dopple.Schedules.EventSchedule.enqueue({:test, "This is a test"})

    test_pid = self()
    agg = Dopple.Aggregators.CallbackAggregator.new(fn evt ->
      send(test_pid, evt)
    end)

    {:ok, agg} = Aggregator.add_measurement(agg, measurement)
    :timer.sleep(500)
    assert_received {:error, %HTTPoison.Error{id: nil, reason: :econnrefused}}

  end
end
