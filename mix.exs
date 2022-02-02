defmodule Platem.MixProject do
  use Mix.Project

  def project do
    [
      app: :platem,
      description: "Platem is a simple, fast, and powerful templating engine for Elixir.",
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        name: "platem",
        licenses: ["MIT"],
        maintainers: ["Joost de Jager", "Shivam Badal", "Thijs van der Heijden"],
        links: %{"GitHub" => "https://github.com/hergetto/platem/"}
      ],
      docs: [
        main: "readme",
        source_ref: "master",
        extras: ["README.md"]
      ]
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
