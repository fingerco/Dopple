defprotocol Dopple.Measurement do
  @spec add_schedule(__MODULE__.t, Schedule.t) :: {:ok, __MODULE__.t} | {:error, any}
  def add_schedule(measurement, schedule)

  @spec add_target(__MODULE__.t, Target.t) :: {:ok, __MODULE__.t} | {:error, any}
  def add_target(measurement, target)

  @spec producer(__MODULE__.t) :: {:ok, GenStage.stage} | {:error, any}
  def producer(measurement)
end
