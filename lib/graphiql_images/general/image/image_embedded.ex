defmodule GraphiQLImages.General.Image.ImageEmbedded do
  @moduledoc """
  ImageEmbedded module for manager images (database)
  """
  use GraphiQLImages.Schema
  use Waffle.Ecto.Schema

  import Ecto.Changeset

  alias GraphiQLImages.General.Image.ImageUploader

  @primary_key false
  embedded_schema do
    field(:image, ImageUploader.Type)
    field(:type, :string)
    field(:uuid, :string)
  end

  @required_fields [:uuid, :type]
  @optional_fields []

  def changeset(image, params) do
    image
    |> cast(params, @required_fields ++ @optional_fields)
    |> cast_attachments(params, [:image])
  end
end
