defmodule Dopple.MixProject do
  use Mix.Project

  def project do
    [
      app: :dopple,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      dialyzer: dialyzer(),
      name: "Dopple",
      description: "A library that pings services and measures the results",
      source_url: "https://github.com/polymorfiq-tools/dopple"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gen_stage, "~> 1.1"},
      {:uuid, "~> 1.1"},
      {:httpoison, "~> 1.8"},
      {:mox, "~> 0.5", only: [:test, :dev]},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "dopple",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["AGPL-3.0-or-later"],
      links: %{"GitHub" => "https://github.com/polymorfiq-tools/dopple"}
    ]
  end

  defp dialyzer do
    [
      plt_core_path: "priv/plts",
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end
end
