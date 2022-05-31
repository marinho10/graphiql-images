defmodule GraphiQLImagesWeb.Router do
  @moduledoc """
  Router for GraphiQLImagesWeb
  """
  use GraphiQLImagesWeb, :router

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

  scope "/" do
    pipe_through [:browser]
    live_dashboard "/dashboard", metrics: GraphiQLImagesWeb.Telemetry, ecto_repos: [GraphiQLImages.Repo]
  end

  scope "/api" do
    pipe_through :graphql

    # GraphiQl endpoint
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GraphiQLImagesGraphQL.Schema,
      default_url: Application.get_env(:graphiql_images, :graphql_default_url, "http://localhost:4000/api/graphql"),
      interface: :advanced,
      adapter: Absinthe.Adapter,
      socket: GraphiQLImagesWeb.UserSocket

    # GraphQl endpoint
    forward "/graphql", Absinthe.Plug, schema: GraphiQLImagesGraphQL.Schema
  end
end
