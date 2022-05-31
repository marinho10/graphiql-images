defmodule GraphiQLImagesGraphQL.User.Query.UserTest do
  @moduledoc """
  The User Test.
  """
  use GraphiQLImagesWeb.ConnCase

  import GraphiQLImages.Factory

  @graphiql_path "/api/graphql"

  @query """
  query user($id: ID!) {
    user(id: $id) {
      id
      email
    }
  }
  """

  describe "User Test" do
    @tag :normal
    test "User query - valid id" do
      user = insert(:user)

      response =
        post(build_conn(), @graphiql_path, %{
          query: @query,
          variables: %{
            "id" => user.id
          }
        })

      assert %{
               "data" => %{
                 "user" => %{
                   "id" => id,
                   "email" => _
                 }
               }
             } = json_response(response, 200)

      assert id === user.id
    end

    @tag :normal
    test "User query - invalid id" do
      insert(:user)

      response =
        post(build_conn(), @graphiql_path, %{
          query: @query,
          variables: %{
            "id" => Ecto.UUID.generate()
          }
        })

      assert %{
               "data" => %{"user" => nil},
               "errors" => [
                 %{
                   "extensions" => %{"code" => "NOT_FOUND", "timestamp" => _},
                   "locations" => [%{"column" => 3, "line" => 2}],
                   "message" => "Resource not found",
                   "path" => ["user"]
                 }
               ]
             } = json_response(response, 200)
    end
  end
end
