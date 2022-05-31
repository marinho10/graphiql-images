defmodule GraphiQLImagesGraphQL.User.Resolver do
  @moduledoc """
  Auth/Users Resolver
  """

  alias GraphiQLImages.Users

  #
  # Queries
  #

  def user(_, %{id: id}, _), do: {:ok, Users.get_by_id(id)}
end
