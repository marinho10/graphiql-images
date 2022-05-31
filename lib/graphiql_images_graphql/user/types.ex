defmodule GraphiQLImagesGraphQL.User.Types do
  @moduledoc """
  Users Types
  """
  use Absinthe.Schema.Notation

  alias GraphiQLImagesGraphQL.User.Resolver

  #
  # Objects
  #

  @desc "The user object"
  object :user do
    field(:id, non_null(:id))
    field(:email, non_null(:string))
    field(:name, non_null(:string))

    import_fields(:timestamps)
  end

  #
  # Query
  #

  object :user_queries do
    @desc "
      Get an user by `id`
    "
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(&Resolver.user/3)
    end
  end
end
