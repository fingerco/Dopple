defmodule Dopple.Target.Http do
  @moduledoc """
    A resource that represents an HTTP endpoint
  """

  alias Dopple.{Target, Receipt}
  @enforce_keys [:url, :method]
  defstruct [:url, :method, params: %{}, body: "", headers: [], options: []]

  def new(method, url) do
    %__MODULE__{method: method, url: url}
  end

  defimpl Target, for: __MODULE__ do
    def respond_to(target, _evt) do
      http_resp =
        HTTPoison.request(
          target.method,
          target.url,
          target.body,
          target.headers,
          target.options
        )

      case http_resp do
        {:ok, resp} -> {:ok, Receipt.Http.new(status: resp.status_code, body: resp.body)}
        _ -> http_resp
      end
    end
  end
end
