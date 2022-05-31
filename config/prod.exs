import Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :graphiql_images,
  ecto_repos: [GraphiQLImages.Repo],
  cookie_domain: "localhost",
  cookie_secure: true

# Do not print debug messages in production
config :logger, level: :info

# Configure your database
config :graphiql_images, GraphiQLImages.Repo,
  url: "ecto://postgres:postgres@localhost/graphiql_images_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :graphiql_images, GraphiQLImagesWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [
#         :inet6,
#         port: 443,
#         cipher_suite: :strong,
#         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#         certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
#       ]
#
# The `cipher_suite` is set to `:strong` to support only the
# latest and more secure SSL ciphers. This means old browsers
# and clients may not be supported. You can set it to
# `:compatible` for wider support.
#
# `:keyfile` and `:certfile` expect an absolute path to the key
# and cert in disk or a relative path inside priv, for example
# "priv/ssl/server.key". For all supported SSL configuration
# options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
#
# We also recommend setting `force_ssl` in your endpoint, ensuring
# no data is ever sent via http, always redirecting to https:
#
#     config :graphiql_images, GraphiQLImagesWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
config :threat_optix, ThreatOptixWeb.Endpoint,
  url: [host: "example.com", port: 443],
  load_from_system_env: false,
  server: true,
  http: [
    :inet6,
    ip: {0, 0, 0, 0, 0, 0, 0, 0},
    port: String.to_integer("4000"),
    protocol_options: [idle_timeout: :infinity]
  ],
  live_view: [signing_salt: "liveviewsalt"],
  debug_errors: false,
  check_origin: false
