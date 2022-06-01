defmodule GraphiQLImagesGraphQl.User.GalleryImage.Resolver do
  @moduledoc """
  User GalleryImage Resolver
  """
  alias GraphiQLImages.User.GalleryImages

  #############
  # Mutations #
  #############

  def user_gallery_image_create(%{gallery_image: gallery_image}, _),
    do: GalleryImages.create(%{gallery_image: gallery_image})
end
