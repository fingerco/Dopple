defprotocol Dopple.Target do
  @moduledoc """
    A resource that the system will periodically ping, to receive measurements
  """

  @spec respond_to(__MODULE__.t(), Event) :: {:ok, Receipt} | {:error, any}
  def respond_to(target, event)
end
