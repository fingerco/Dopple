defmodule Dopple.Receipts.EmptyReceipt do
  alias Dopple.Protocols.Receipt
  defstruct [id: UUID.uuid4]

  def new() do
    %__MODULE__{}
  end

  defimpl Receipt, for: __MODULE__ do
    def id(r), do: r.id
    def payload(_r), do: nil
  end
end
