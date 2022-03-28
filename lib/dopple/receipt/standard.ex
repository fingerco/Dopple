defmodule Dopple.Receipt.Standard do
  @moduledoc """
    A standard receipt that can be used to reference a ping
  """

  defstruct id: UUID.uuid4()

  def new, do: %__MODULE__{}
end

defimpl Dopple.Receipt, for: Dopple.Receipt.Standard do
  def id(r), do: r.id
end
