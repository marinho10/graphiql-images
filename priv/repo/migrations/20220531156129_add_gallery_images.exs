defmodule GraphiQLImages.Repo.Migrations.AddGalleryImages do
  use Ecto.Migration

  import Ecto.Query, warn: false

  def up do
    create table(:user_gallery_images) do
      add(:user_id, references(:users, on_delete: :delete_all), null: true)
      add(:gallery_image, :map, null: true, default: %{})
      timestamps()
    end

    create_if_not_exists index(:user_gallery_images, [:user_id])
  end

  def down do
    drop_if_exists index(:user_gallery_images, [:user_id])

    flush()

    drop_if_exists table(:user_gallery_images)
  end
end
