defmodule GraphiQLImages.User.GalleryImage do
  @moduledoc """
  The Gallery Image schema module
  """
  use GraphiQLImages.Schema
  import Ecto.Changeset

  alias GraphiQLImages.General.Image.ImageEmbedded
  alias GraphiQLImages.User

  schema "user_gallery_images" do
    embeds_one :gallery_image, ImageEmbedded, on_replace: :delete
    belongs_to(:user, User)

    timestamps()
  end

  @required_fields []
  @optional_fields [:user_id]

  def changeset(gallery_image, params) do
    gallery_image
    |> cast(params, @required_fields ++ @optional_fields)
    |> foreign_key_constraint(:user_id, message: "invalid_identifier")
    |> cast_embed(:gallery_image)
  end
end
