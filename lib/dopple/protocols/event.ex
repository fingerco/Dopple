defprotocol Dopple.Protocols.Event do
  @spec id(Event) :: atom() | binary()
  def id(event)

  @spec type(Event) :: tuple() | atom()
  def type(event)
end
