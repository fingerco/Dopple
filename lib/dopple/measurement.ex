defprotocol Dopple.Measurement do
  @moduledoc """
    Describes a measurement that should be retrieved from a set of targets on a given a set of schedules
  """

  @spec add_schedule(__MODULE__.t(), Schedule) :: {:ok, __MODULE__.t()} | {:error, any}
  def add_schedule(measurement, schedule)

  @spec add_target(__MODULE__.t(), Target) :: {:ok, __MODULE__.t()} | {:error, any}
  def add_target(measurement, target)

  @spec producer(__MODULE__.t()) :: {:ok, GenStage.stage()} | {:error, any}
  def producer(measurement)
end
