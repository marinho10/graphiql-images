import Config

# Configure your database
config :graphiql_images, GraphiQLImages.Repo,
  url: "ecto://postgres:postgres@localhost/graphiql_images_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 10 * 60 * 1000,
  pool_size: 30

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :graphiql_images, GraphiQLImagesWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
