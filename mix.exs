defmodule GraphiQLImages.MixProject do
  @moduledoc """
  Mix Project

  Version is automatically incremented by github run number
  """
  use Mix.Project

  defp version, do: "0.1.0"

  def project do
    [
      app: :graphiql_images,
      version: get_full_version(),
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      test_paths: ["test"],
      test_pattern: "**/*_test.exs",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "check.linter": :test,
        "check.code.format": :test,
        "check.code.security": :test,
        "check.code.coverage": :test
      ],
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {GraphiQLImages.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix
      {:phoenix, "~> 1.6"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_ecto, "~> 4.4"},
      {:jason, "~> 1.2"},

      # Phoenix Live dashboard
      {:phoenix_live_dashboard, "~> 0.6"},
      {:phoenix_html, "~> 3.1"},
      {:telemetry_poller, "~> 0.5"},
      {:telemetry_metrics, "~> 0.6"},

      # Server
      {:plug_cowboy, "~> 2.5"},
      {:cors_plug, "~> 3.0"},

      # GraphQL
      {:absinthe, "~> 1.7"},
      {:absinthe_plug, "~> 1.5"},
      {:dataloader, "~> 1.0"},
      {:absinthe_error_payload, "~> 1.1"},

      # Database
      {:ecto_sql, "~> 3.7"},
      {:ecto_psql_extras, "~> 0.7"},
      {:postgrex, "~> 0.15"},

      # Translations
      {:gettext, "~> 0.18"},

      # Linting
      {:credo, "~> 1.6", only: [:dev, :test], override: true},
      {:credo_envvar, "~> 0.1", only: [:dev, :test], runtime: false},
      {:credo_naming, "~> 2.0", only: [:dev, :test], runtime: false},

      # Security check
      {:sobelow, "~> 0.11", only: [:dev, :test], runtime: true},
      {:mix_audit, "~> 1.0", only: [:dev, :test], runtime: false},

      # Test factories
      {:ex_machina, "~> 2.5", only: :test},
      {:faker, "~> 0.17", only: :test},

      # Test coverage
      {:excoveralls, "~> 0.14", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases,
    do: [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      compile: ["compile --warnings-as-errors"],
      test: ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "check.linter": ["credo --strict"],
      "check.code.format": ["format --dry-run --check-formatted"],
      "check.code.security": ["sobelow --config", "deps.audit"],
      "check.code.coverage": ["coveralls"]
    ]

  defp get_full_version, do: "#{version()}#{get_github_run_number()}"

  defp get_github_run_number do
    case get_ci(System.get_env("CI")) do
      true -> "-#{System.get_env("GITHUB_RUN_NUMBER")}"
      _ -> ""
    end
  end

  defp get_ci("true"), do: true
  defp get_ci("false"), do: false
  defp get_ci(value), do: value
end
