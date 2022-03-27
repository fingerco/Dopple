defprotocol Dopple.Protocols.Aggregator do
  alias Dopple.Protocols.Measurement

  @spec add_measurement(__MODULE__.t, Measurement.t) :: {:ok, __MODULE__.t} | {:error, any}
  def add_measurement(agg, measurement)

  @spec consumer(__MODULE__.t) :: {:ok, GenStage.stage} | {:error, any}
  def consumer(agg)
end
