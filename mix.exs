defmodule Dopple.MixProject do
  use Mix.Project

  def project do
    [
      app: :dopple,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gen_stage, "~> 1.1"},
      {:uuid, "~> 1.1"},
      {:httpoison, "~> 1.8"},
      {:mox, "~> 0.5", only: [:test, :dev]}
    ]
  end
end
