defmodule GraphiQLImagesGraphQL.User.Types do
  @moduledoc """
  Users Types
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias GraphiQLImagesGraphQL.User.Resolver

  ##################
  # Inputs Objects #
  ##################

  @desc "The user input object"
  input_object :user_input do
    field(:email, non_null(:string))
    field(:name, non_null(:string))
    field(:surname, non_null(:string))
    field(:gallery, non_null(list_of(non_null(:id))))
  end

  @desc "The update user input object"
  input_object :update_user_input do
    field(:email, :string)
    field(:name, :string)
    field(:surname, :string)
    field(:gallery, list_of(non_null(:id)))
  end

  ###############
  #   Objects   #
  ###############

  @desc "The user object"
  object :user do
    field(:id, non_null(:id))
    field(:email, non_null(:string))
    field(:name, non_null(:string))
    field(:surname, non_null(:string))

    field(:gallery, list_of(:user_gallery_image)) do
      resolve(dataloader(Repo))
    end

    import_fields(:timestamps)
  end

  ############
  # Queries  #
  ############

  object :user_queries do
    @desc "Get an user by `id`"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolver.user/3)
    end
  end

  ##############
  # Mutations  #
  ##############

  object :user_mutations do
    @desc "Create new user"
    field(:user_create, :user) do
      arg(:input, non_null(:user_input))
      resolve(&Resolver.user_create/2)
    end

    @desc "Edit an user"
    field(:user_update, :user) do
      arg(:id, non_null(:id))
      arg(:input, non_null(:update_user_input))
      resolve(&Resolver.user_update/2)
    end
  end
end
