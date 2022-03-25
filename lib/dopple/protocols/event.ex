defprotocol Dopple.Protocols.Event do
  @spec id(__MODULE__) :: atom() | binary()
  def id(event)

  @spec type(__MODULE__.t) :: tuple() | atom()
  def type(event)
end
