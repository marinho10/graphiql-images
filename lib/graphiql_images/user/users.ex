defmodule GraphiQLImages.Users do
  @moduledoc """
  Module responsible for CRUD and direct actions
  with `User` schema and `users` table.
  """

  alias Ecto.Multi
  alias GraphiQLImages.General.GeneralQuery
  alias GraphiQLImages.Repo
  alias GraphiQLImages.User
  alias GraphiQLImages.User.GalleryImage.Query, as: GalleryImageQuery
  alias GraphiQLImages.User.GalleryImages

  @preload_fields [:gallery]

  @doc """
  Gets a user by id.

  Returns `%User{}` or `nil`

  ## Examples

    iex> GraphiQLImages.Users.get_by_id("aaaa-bbbb-cccc-dddd")
    %User{}

    iex> GraphiQLImages.Users.get_by_id("invalid-id")
    nil

  """
  def get_by_id(id)
  def get_by_id(id) when id in [nil, ""], do: nil
  def get_by_id(id), do: User |> GeneralQuery.preload_by(@preload_fields) |> Repo.get(id)

  @doc """
  Create a new user.

  Returns `{:ok, %User{}}` or `{:error, changeset}`

  ## Examples

    iex> GraphiQLImages.Users.create("valid attrs")
    {:ok, %User{}}

    iex> GraphiQLImages.Users.create("invalid attrs")
    {:error, changeset}

  """
  def create(attrs) do
    Multi.new()
    |> Multi.insert(:user, User.changeset(%User{}, attrs))
    |> Multi.run(
      :update_images,
      fn _, %{user: user} ->
        update_images(attrs[:gallery], user)
      end
    )
    |> Repo.transaction()
    |> case do
      {:ok, %{user: user, update_images: _}} ->
        {:ok, user}

      {:error, _, changeset, _} ->
        {:error, changeset}

      _ ->
        {:error, nil}
    end
  end

  @doc """
  Update an user.

  Returns `{:ok, %User{}}` or `{:error, changeset}` or `nil`

  ## Examples

    iex> GraphiQLImages.Users.update(user,"valid attrs")
    {:ok, %User{}}

    iex> GraphiQLImages.Users.update(user, "invalid attrs")
    {:error, changeset}

    iex> GraphiQLImages.Users.update(nil, "attrs")
    nil

  """
  def update(user, attrs)
  def update(nil, _), do: nil

  def update(%User{} = user, attrs) do
    Multi.new()
    |> Multi.update(:user, User.changeset(user, attrs))
    |> Multi.run(:delete_images, fn _, _ ->
      ids =
        ((user.gallery || []) |> Enum.map(& &1.id)) --
          (attrs[:gallery] || [])

      {delete_images(ids), ids}
    end)
    |> Multi.run(
      :update_images,
      fn _, %{user: user} ->
        update_images(attrs[:gallery], user)
      end
    )
    |> Repo.transaction()
    |> case do
      {:ok, %{user: user, delete_images: _, update_images: _}} ->
        {:ok, user}

      {:error, _, changeset, _} ->
        {:error, changeset}

      _ ->
        {:error, nil}
    end
  end

  # update images with user
  defp update_images(ids, user)
  defp update_images(ids, _) when ids in [nil, [], ""], do: {:ok, nil}

  defp update_images(ids, user) do
    {:ok, Repo.update_all(GalleryImageQuery.filter_by_ids(ids), set: [user_id: user.id])}
  end

  # delete images if unused/removed from the database and S3
  defp delete_images(ids)
  defp delete_images(ids) when ids in [nil, [], ""], do: :ok

  defp delete_images(ids) do
    ids
    |> GalleryImageQuery.filter_by_ids()
    |> GalleryImages.delete()
  end
end
