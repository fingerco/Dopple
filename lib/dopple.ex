defmodule Dopple do
  @moduledoc """
    A library that pings services and measures the results
  """

  @type ping_status() :: {:ok, any()} | {:error, any()} | {:processing, any()}
end
