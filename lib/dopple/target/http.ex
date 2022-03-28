defmodule Dopple.Target.Http do
  @moduledoc """
    A resource that represents an HTTP endpoint
  """

  use GenServer
  @enforce_keys [:pid, :url, :method]
  defstruct [:pid, :url, :method, params: %{}, body: "", headers: [], options: []]

  def new(method, url) do
    {:ok, pid} = __MODULE__.start_link()
    %__MODULE__{pid: pid, method: method, url: url}
  end

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    {:ok, {}}
  end

  def handle_cast({:ping, _target, _receipt}, state) do
    {:noreply, state}
  end
end

defimpl Dopple.Target, for: Dopple.Target.Http do
  def ping(target, _evt) do
    receipt = Dopple.Receipt.Standard.new()
    GenServer.cast(target.pid, {:ping, target, receipt})

    {:ok, receipt}
  end
end
