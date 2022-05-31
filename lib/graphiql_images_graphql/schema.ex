defmodule GraphiQLImagesGraphQL.Schema do
  @moduledoc """
  GraphQL Schema
  """
  use Absinthe.Schema

  alias GraphiQLImages.Repo
  alias GraphiQLImagesGraphQL.Middleware

  def context(context),
    do:
      Map.put(
        context,
        :loader,
        Dataloader.add_source(Dataloader.new(), Repo, Dataloader.Ecto.new(Repo))
      )

  def plugins,
    do: [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()

  # Middleware - errors
  def middleware(middleware, _field, %{identifier: type})
      when type in [:query, :mutation] do
    middleware ++ [Middleware.Errors]
  end

  def middleware(middleware, _field, _object), do: middleware

  import_types(Absinthe.Type.Custom)
  import_types(GraphiQLImagesGraphQL.General.Types)
  import_types(GraphiQLImagesGraphQL.Application.Types)
  import_types(GraphiQLImagesGraphQL.User.Types)

  #
  # Queries
  #

  query do
    import_fields(:application_queries)
    import_fields(:user_queries)
  end
end
