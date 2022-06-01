defmodule GraphiQLImages.User.GalleryImages do
  @moduledoc """
  GalleryImages context
  """
  alias Ecto.Multi
  alias GraphiQLImages.General.Image.ImageUploader
  alias GraphiQLImages.Repo
  alias GraphiQLImages.User.GalleryImage

  @doc """
  Gets an gallery image by id.

  Returns `%GalleryImage{}` or `nil`

  ## Examples

    iex> GraphiQLImages.User.GalleryImages.get_by_id("aaaa-bbbb-cccc-dddd")
    %GalleryImage{}

    iex> GraphiQLImages.User.GalleryImages.get_by_id("invalid-id")
    nil

  """
  def get_by_id(id)
  def get_by_id(id) when id in [nil, ""], do: nil
  def get_by_id(id), do: GalleryImage |> Repo.get(id)

  @doc """
  Create/upload gallery image

  Returns `{:ok, %GalleryImage{}}` or `{:error, changeset}`

  ## Examples

    iex> GraphiQLImages.User.GalleryImages.create("valid attrs")
    {:ok, %GalleryImage{}}

    iex> GraphiQLImages.User.GalleryImages.create("invalid attrs")
    {:error, changeset}

  """
  def create(attrs) do
    attrs = generate_uuid_for_image(nil, attrs)

    %GalleryImage{}
    |> GalleryImage.changeset(attrs)
    |> Repo.insert()
  end

  # generate uuid for image
  defp generate_uuid_for_image(image, attrs)

  defp generate_uuid_for_image(%{image: %{uuid: uuid}}, %{gallery_image: gallery_image} = attrs)
       when not is_nil(uuid) do
    Map.put(attrs, :gallery_image, %{image: gallery_image, type: "users", uuid: uuid})
  end

  defp generate_uuid_for_image(_, %{gallery_image: gallery_image} = attrs) do
    Map.put(attrs, :gallery_image, %{image: gallery_image, type: "users", uuid: "#{UUID.uuid1()}"})
  end

  defp generate_uuid_for_image(_, attrs), do: attrs

  @doc """
  Delete gallery image by query

  Returns `:ok` or `:error`

  ## Examples

    iex> GraphiQLImages.User.GalleryImages.delete(query)
    :ok

  """
  def delete(query)
  def delete(query) when query in [nil, "", []], do: :ok

  def delete(query) do
    Multi.new()
    |> Multi.delete_all(:delete_images, query)
    |> Multi.run(:delete_images_s3, fn _, _ ->
      images = query |> Repo.all()

      {
        :ok,
        Enum.map(images, &ImageUploader.delete({&1.gallery_image.image, &1.gallery_image}))
      }
    end)
    |> Repo.transaction()
    |> case do
      {:ok, _} -> :ok
      _ -> :error
    end
  end
end
