defmodule GraphiQLImagesWeb.Router do
  use GraphiQLImagesWeb, :router

  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  pipeline :graphql do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(:put_secure_browser_headers)
    plug(GraphiQLImagesGraphQL.Context)
  end

  pipeline :browser do
    plug(:accepts, ["html", "json"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :admins_only do
    plug(
      :basic_auth,
      username: Application.get_env(:graphiql_images, :live_dashboard_password) || "admin",
      password: Application.get_env(:graphiql_images, :live_dashboard_password) || "admin"
    )
  end

  scope "/" do
    pipe_through [:admins_only, :browser]
    live_dashboard "/dashboard", metrics: GraphiQLImagesWeb.Telemetry, ecto_repos: [GraphiQLImages.Repo]
  end

  scope "/v1" do
    pipe_through :graphql

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: GraphiQLImagesGraphQL.Schema
    forward "/graphql", Absinthe.Plug, schema: GraphiQLImagesGraphQL.Schema
  end
end
