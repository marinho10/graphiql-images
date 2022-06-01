defmodule GraphiQLImagesGraphQl.User.GalleryImage.Types do
  @moduledoc """
  GalleryImage Types
  """
  use Absinthe.Schema.Notation

  alias GraphiQLImagesGraphQl.General.Resolver, as: GeneralResolver
  alias GraphiQLImagesGraphQl.User.GalleryImage.Resolver, as: UserGalleryImageResolver

  ###############
  #   Objects   #
  ###############

  @desc "The user gallery image object"
  object(:user_gallery_image) do
    field(:id, non_null(:id))

    field(:gallery_image, non_null(:file_image)) do
      resolve(&GeneralResolver.gallery_image/3)
    end

    import_fields(:timestamps)
  end

  ##############
  # Mutations  #
  ##############

  object(:user_gallery_image_mutations) do
    @desc "Create a new user gallery image"
    field(:user_gallery_image_create, :user_gallery_image) do
      arg(:gallery_image, non_null(:upload))

      resolve(&UserGalleryImageResolver.user_gallery_image_create/2)
    end
  end
end
