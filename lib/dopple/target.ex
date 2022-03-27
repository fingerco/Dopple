defprotocol Dopple.Target do
  @spec respond_to(__MODULE__.t(), Event.t()) :: {:ok, Receipt.t()} | {:error, any}
  def respond_to(target, event)
end
