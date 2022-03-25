defprotocol Dopple.Protocols.Receipt do
  @spec id(Receipt) :: atom() | binary()
  def id(recpt)

  @spec payload(Receipt) :: any
  def payload(recpt)
end
