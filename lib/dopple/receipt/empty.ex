defmodule Dopple.Receipt.Empty do
  @moduledoc """
    A receipt that describes an empty response
  """

  alias Dopple.Receipt
  defstruct id: UUID.uuid4()

  def new do
    %__MODULE__{}
  end

  defimpl Receipt, for: __MODULE__ do
    def id(r), do: r.id
    def payload(_r), do: nil
  end
end
