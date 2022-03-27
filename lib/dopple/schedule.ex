defprotocol Dopple.Schedule do
  @spec producer(__MODULE__.t()) :: {:ok, GenStage.stage()} | {:error, any}
  def producer(schedule)
end
