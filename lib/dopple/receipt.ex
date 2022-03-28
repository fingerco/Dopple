defprotocol Dopple.Receipt do
  @moduledoc """
    A token acknowledging the request to ping a target
  """

  @spec id(__MODULE__.t()) :: atom() | binary()
  def id(recpt)
end
