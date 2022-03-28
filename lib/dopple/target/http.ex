defmodule Dopple.Target.Http do
  @moduledoc """
    A resource that represents an HTTP endpoint
  """

  @enforce_keys [:url, :method]
  defstruct [:url, :method, params: %{}, body: "", headers: [], options: []]

  def new(method, url) do
    %__MODULE__{method: method, url: url}
  end
end

defimpl Dopple.Target, for: Dopple.Target.Http do
  def ping(target, _evt) do
    receipt = Dopple.Receipt.Standard.new()
    GenServer.cast(target.stage, {:ping, receipt})

    {:ok, receipt}
  end
end
