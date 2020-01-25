defmodule CIDR.MixProject do
  use Mix.Project

  def project do
    [
      app: :cidr,
      version: "0.1.0",
      elixir: "~> 1.9",
      escript: escript(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def escript do
    [
      main_module: CIDR.CLI,
      path: "./bin/cidr"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps, do: []
end
