defprotocol Dopple.Protocols.Schedule do
  alias Dopple.Protocols.Target
  alias Dopple.Protocols.Receipt

  @spec apply_to(__MODULE__, Target) :: {:ok, Receipt} | {:error, any}
  def apply_to(schedule, target)
end
