defmodule Dopple.Targets.HttpTarget do
  alias Dopple.Protocols.Target
  alias Dopple.Receipts.HttpReceipt

  @enforce_keys [:url, :method]
  defstruct     [:url, :method, params: %{}, body: "", headers: [], options: []]

  def new(method, url) do
    %__MODULE__{method: method, url: url}
  end

  defimpl Target, for: __MODULE__ do
    def respond_to(target, _evt) do
      http_resp = HTTPoison.request(
        target.method,
        target.url,
        target.body,
        target.headers,
        target.options
      )

      case http_resp do
        {:ok, resp} -> {:ok, HttpReceipt.new(status: resp.status_code, body: resp.body)}
        _ -> http_resp
      end
    end

  end
end
