defprotocol Dopple.Protocols.Target do
  alias Dopple.Protocols.Event

  @spec respond_to(__MODULE__.t, Event.t) :: {:ok, Receipt.t} | {:error, any}
  def respond_to(target, event)

  @spec send(__MODULE__.t, Event.t) :: :ok | {:error, any}
  def send(target, event)
end
