import Config

# General Application configuration
config :graphiql_images,
  ecto_repos: [GraphiQLImages.Repo],
  graphql_default_url: "http://localhost:4000/api/graphql"

# Repo configuration
config :graphiql_images, GraphiQLImages.Repo,
  migration_primary_key: [name: :id, type: :binary_id],
  timeout: 60_000,
  queue_target: 5_000

# Endpoint configuration
config :graphiql_images, GraphiQLImagesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vFARunaybVxzlIZHxm2P8m6xmA6IaIeSF1X3ZFNSHPBNXqc2GpiRPcILldr5QSNy",
  render_errors: [view: GraphiQLImagesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GraphiQLImages.PubSub,
  live_view: [signing_salt: "default_secret_salt"]

# CORS - configuration
config :cors_plug,
  max_age: 86_400,
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]

# Logger configuration
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Jason configuration
config :phoenix, :json_library, Jason

# esbuild configuration
config :esbuild, :version, "0.14.41"

# Waffle configuration
config :waffle,
  storage: Waffle.Storage.Local,
  # 30 seconds
  version_timeout: 30_000

# ExAws configuration
config :ex_aws,
  json_codec: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config("#{config_env()}.exs")
