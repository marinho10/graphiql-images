defmodule GraphiQLImagesGraphQL.Application.Types do
  @moduledoc """
  Application Types
  """
  use Absinthe.Schema.Notation

  #
  # Objects
  #

  object :application do
    @desc "The application version"
    field(:version, :string)
  end

  #
  # Queries
  #

  object :application_queries do
    @desc "Application information"
    field :application, :application do
      resolve(fn _, _, _ ->
        {:ok, %{version: version()}}
      end)
    end
  end

  #
  # Private functions
  #

  defp version, do: Application.spec(:graphiql_images, :vsn)
end
