defprotocol Dopple.Protocols.Schedule do
  alias Dopple.Protocols.Target
  alias Dopple.Protocols.Receipt

  @spec apply_to(__MODULE__.t, Target.t) :: {:ok, Receipt.t} | {:error, any}
  def apply_to(schedule, target)
end
