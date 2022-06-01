defmodule GraphiQLImagesGraphQl.General.Resolver do
  @moduledoc """
  General Resolver
  """

  alias GraphiQLImages.General.Image.ImageUploader

  ###########
  # Queries #
  ###########

  def gallery_image(_, _, %{source: %{gallery_image: nil}}), do: {:ok, nil}

  def gallery_image(_, _, %{source: %{gallery_image: %{uuid: nil}}}),
    do: {:ok, nil}

  def gallery_image(_, _, %{source: %{gallery_image: image_embedded}}),
    do: {:ok, ImageUploader.urls({image_embedded.image, image_embedded})}
end
