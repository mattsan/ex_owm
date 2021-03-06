defmodule ExOwm.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_owm,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {ExOwm.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.3.0"},
      {:poison, "~> 4.0.1"},
      {:timex, "~> 3.3.0"},
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false}
    ]
  end
end
