defprotocol Dopple.Protocols.Target do
  alias Dopple.Protocols.Event

  @spec respond_to(Target, Event) :: {:ok, Receipt} | {:error, any}
  def respond_to(target, event)

  @spec send(Target, Event) :: :ok | {:error, any}
  def send(target, event)
end
