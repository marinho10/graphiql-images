defmodule GraphiQLImagesGraphQL.Application.Query.ApplicationTest do
  @moduledoc """
  The Application Test.
  """
  use GraphiQLImagesWeb.ConnCase

  @graphiql_path "/api/graphql"

  @query """
  query {
    application {
      version
    }
  }
  """

  describe "Application Test" do
    @tag :normal
    test "Application query success" do
      response =
        post(build_conn(), @graphiql_path, %{
          query: @query,
          variables: %{}
        })

      version = Application.spec(:graphiql_images, :vsn)

      assert %{
               "data" => %{
                 "application" => %{
                   "version" => to_string(version)
                 }
               }
             } === json_response(response, 200)
    end
  end
end
