defmodule GraphiQLImages.User.GalleryImage.Query do
  @moduledoc """
  GalleryImage queries
  """
  import Ecto.Query, warn: false

  alias GraphiQLImages.User.GalleryImage

  @doc """
  Base query for GalleryImages.
  """
  def base, do: GalleryImage |> from(as: :gallery_image)

  @doc """
  Filter by ids

  Returns `#Ecto.Query<>`

  ## Examples

    iex> GraphiQLImages.User.GalleryImage.Query.filter_by_ids(query \\ base(), ["id"])
    query

  """
  def filter_by_ids(query \\ base(), ids)
  def filter_by_ids(query, ids) when ids in [nil, "", []], do: query
  def filter_by_ids(query, ids), do: query |> where([gallery_image: gi], gi.id in ^ids)

  @doc """
  Filter by nil users

  Returns `#Ecto.Query<>`

  ## Examples

    iex> GraphiQLImages.User.GalleryImage.Query.filter_by_nil_user(query \\ base())
    query

  """
  def filter_by_nil_user(query \\ base())

  def filter_by_nil_user(query),
    do:
      query
      |> where([gallery_image: gi], is_nil(gi.user_id))

  @doc """
  Filter by inserted_at

  Returns `#Ecto.Query<>`

  ## Examples

    iex> GraphiQLImages.User.GalleryImage.Query.filter_by_inserted_at(query \\ base(), inserted_at)
    query

  """
  def filter_by_inserted_at(query \\ base(), inserted_at)
  def filter_by_inserted_at(query, inserted_at) when inserted_at in [nil, "", []], do: query

  def filter_by_inserted_at(query, inserted_at),
    do:
      query
      |> where([gallery_image: gi], gi.inserted_at < ^inserted_at)
end
