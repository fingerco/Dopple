defprotocol Dopple.Protocols.Receipt do
  @spec id(__MODULE__.t) :: atom() | binary()
  def id(recpt)

  @spec payload(__MODULE__.t) :: any
  def payload(recpt)
end
