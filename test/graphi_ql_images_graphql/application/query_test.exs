defmodule GraphiQLImagesGraphQL.Application.QueryTest do
  use GraphiQLImagesWeb.ConnCase

  describe "application" do
    @query """
    query {
      application {
        version
      }
    }
    """

    @tag :normal
    test "version" do
      response =
        post(build_conn(), "/v1/graphql", %{
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
