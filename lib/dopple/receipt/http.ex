defmodule Dopple.Receipt.Http do
  alias Dopple.Receipt

  @enforce_keys [:status, :body]
  defstruct [:status, :body, id: UUID.uuid4()]

  def new(status: status, body: body) do
    %__MODULE__{status: status, body: body}
  end

  defimpl Receipt, for: __MODULE__ do
    def id(r), do: r.id
    def payload(r), do: %{status: r.status, body: r.body}
  end
end
