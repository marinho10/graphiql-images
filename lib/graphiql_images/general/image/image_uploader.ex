defmodule GraphiQLImages.General.Image.ImageUploader do
  @moduledoc """
  ImageUploader module for manager images (file and upload)
  """

  use Waffle.Definition
  use Waffle.Ecto.Definition

  @versions [:original, :small]
  @extensions [:jpg, :jpeg, :gif, :png]

  def validate({file, _}) do
    with {:ok, type} <- Fastimage.type(file.path) do
      Enum.member?(@extensions, type)
    end
  end

  def transform(:small, _),
    do: {:convert, "-strip -auto-orient -resize 160x160> -format png", :png}

  def transform(:original, _),
    do: {:convert, "-strip -auto-orient -resize 1080x1080> -format png", :png}

  def filename(version, {_, image}), do: "#{image.uuid}_#{version}"

  def storage_dir(_, {_, %{type: type}}), do: "uploads/#{type}/images/"

  def s3_object_headers(_, {_, _}), do: [content_type: "image/png"]
end
