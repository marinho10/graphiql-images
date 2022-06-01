defmodule GraphiQLImagesGraphQL.User.Resolver do
  @moduledoc """
  Users Resolver
  """

  alias GraphiQLImages.Users

  ############
  # Queries  #
  ############

  def user(_, %{id: id}, _), do: {:ok, Users.get_by_id(id)}

  #############
  # Mutations #
  #############

  def user_create(%{input: params}, _),
    do: Users.create(params)

  def user_update(%{id: id, input: params}, _), do: Users.update(Users.get_by_id(id), params)
end
