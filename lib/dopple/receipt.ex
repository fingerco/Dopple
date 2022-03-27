defprotocol Dopple.Receipt do
  @moduledoc """
    A token acknowledging the request to ping a target
  """

  @spec id(__MODULE__.t()) :: atom() | binary()
  def id(recpt)

  @spec payload(__MODULE__.t()) :: any()
  def payload(recpt)
end
