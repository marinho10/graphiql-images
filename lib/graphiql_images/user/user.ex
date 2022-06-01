defmodule GraphiQLImages.User do
  @moduledoc """
  Module Schema for `User`.
  """

  use GraphiQLImages.Schema
  import Ecto.Changeset

  alias GraphiQLImages.User.GalleryImage

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:surname, :string)

    has_many :gallery, GalleryImage, on_replace: :delete, on_delete: :delete_all

    timestamps()
  end

  @email_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,12}$/

  @required_fields [:email, :name, :surname]
  @optional_fields []

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields, message: "field_is_required")
    |> unique_constraint(:email, message: "email_has_been_taken")
    |> validate_format(:email, @email_regex, message: "invalid_email_format")
  end
end
