defprotocol Dopple.Event do
  @moduledoc """
    Describes the event that caused the system to ping a target
  """

  @spec id(__MODULE__.t()) :: atom() | binary()
  def id(event)

  @spec type(__MODULE__.t()) :: atom()
  def type(event)

  @spec value(__MODULE__.t()) :: any()
  def value(event)
end
