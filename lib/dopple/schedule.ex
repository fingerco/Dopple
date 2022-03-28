defprotocol Dopple.Schedule do
  @moduledoc """
    A decision mechanism for when to send out a ping
  """

  @spec producer(__MODULE__.t()) :: {:ok, GenStage.stage()} | {:error, any}
  def producer(schedule)
end
