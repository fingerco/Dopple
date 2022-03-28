defprotocol Dopple.Target do
  @moduledoc """
    A resource that the system will periodically ping, to receive measurements
  """

  alias Dopple.Receipt

  @spec ping(__MODULE__, Event) :: {:ok, Receipt.t()} | {:error, any}
  def ping(target, event)
end
