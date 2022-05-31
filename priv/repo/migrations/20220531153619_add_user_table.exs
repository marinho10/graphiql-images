defmodule GraphiQLImages.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def up do
    create table(:users) do
      add(:email, :string, null: false)
      add(:name, :string, null: true)
      add(:surname, :string, null: true)

      timestamps()
    end

    create_if_not_exists unique_index(:users, :email)
  end

  def down do
    drop_if_exists table(:users)
  end
end
