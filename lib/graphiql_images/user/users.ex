defmodule GraphiQLImages.Users do
  @moduledoc """
  Module responsible for CRUD and direct actions
  with `User` schema and `users` table.
  """

  alias GraphiQLImages.Repo
  alias GraphiQLImages.User

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
  def get_by_id(id), do: User |> Repo.get(id)
end
