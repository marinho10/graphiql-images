import Config

# General Application configuration
config :graphiql_images,
  ecto_repos: [GraphiQLImages.Repo],
  graphql_default_url: "http://localhost:4000/v1/graphql",
  live_dashboard_username: "admin",
  live_dashboard_password: "admin",
  cookie_domain: "localhost",
  session_key: "_local_graphiql_images_key",
  virtual_env: "localhost",
  cookie_signing_salt: "default_secret_salt",
  token_signing_salt: "default_secret_salt"


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

# Esbuild configuration
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config("#{config_env()}.exs")
