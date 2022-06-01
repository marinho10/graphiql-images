defmodule GraphiQLImagesGraphQL.Schema do
  @moduledoc """
  GraphQL Schema
  """
  use Absinthe.Schema

  alias GraphiQLImagesGraphQl.Middleware

  @doc """
  Define the GraphQL context
  """
  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Repo, GraphiQLImagesGraphQl.Dataloader.data())

    Map.put(context, :loader, loader)
  end

  @doc """
  Define the GraphQL middleware
  """
  def middleware(middleware, _field, %{identifier: type})
      when type in [:query, :mutation] do
    middleware ++ [Middleware.Errors]
  end

  def middleware(middleware, _field, _object), do: middleware

  @doc """
  Define the GraphQL plugins
  """
  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  import_types(Absinthe.Plug.Types)
  import_types(Absinthe.Type.Custom)
  import_types(GraphiQLImagesGraphQL.General.Types)
  import_types(GraphiQLImagesGraphQL.Application.Types)
  import_types(GraphiQLImagesGraphQL.User.Types)
  import_types(GraphiQLImagesGraphQl.User.GalleryImage.Types)

  ############
  # Queries  #
  ############

  query do
    import_fields(:application_queries)
    import_fields(:user_queries)
  end

  ##############
  # Mutations  #
  ##############

  mutation do
    import_fields(:user_mutations)
    import_fields(:user_gallery_image_mutations)
  end
end
