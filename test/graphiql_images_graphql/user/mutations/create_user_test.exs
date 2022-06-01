defmodule GraphiQLImagesGraphQl.User.Mutations.CreateUserTest do
  @moduledoc """
  Tests GraphQl create user
  """
  import GraphiQLImages.Factory
  use GraphiQLImagesWeb.ConnCase, async: true

  @base_url "/api/graphql"

  @mutation """
  mutation userCreate($input: UserInput!) {
    userCreate(input: $input) {
      name
      gallery {
        galleryImage {
          small
        }
      }
    }
  }
  """

  @mutation_create_image """
  mutation user_gallery_image_create($gallery_image: Upload!) {
    user_gallery_image_create(gallery_image: $gallery_image) {
      id
      galleryImage {
        small
      }
    }
  }
  """

  describe "create user mutation" do
    defp variables do
      user =
        build(:user)
        |> Map.from_struct()

      %{
        email: user.email,
        name: user.name,
        surname: user.surname,
        gallery: []
      }
    end

    @tag :normal
    test "create an user, giving right params" do
      variables = variables()

      response =
        post(build_conn(), @base_url, %{
          query: @mutation,
          variables: %{
            "input" => variables
          }
        })

      assert %{
               "data" => %{
                 "userCreate" => %{
                   "name" => variables.name,
                   "gallery" => []
                 }
               }
             } == json_response(response, 200)
    end

    @tag :normal
    test "create an user, giving right params and images" do
      test_image = upload_image_file()

      response =
        post(build_conn(), @base_url, %{
          query: @mutation_create_image,
          variables: %{
            "gallery_image" => "test"
          },
          test: test_image
        })

      assert %{
               "data" => %{
                 "user_gallery_image_create" => %{"id" => id}
               }
             } = json_response(response, 200)

      response =
        post(build_conn(), @base_url, %{
          query: @mutation,
          variables: %{
            "input" => variables() |> Map.put(:gallery, [id])
          }
        })

      assert %{
               "data" => %{
                 "userCreate" => %{
                   "name" => _,
                   "gallery" => [%{"galleryImage" => %{"small" => _}}]
                 }
               }
             } = json_response(response, 200)
    end
  end
end
