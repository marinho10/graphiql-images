defmodule GraphiQLImagesGraphQl.User.Mutations.UpdateUserTest do
  @moduledoc """
  Tests GraphQl update user
  """
  import GraphiQLImages.Factory
  use GraphiQLImagesWeb.ConnCase, async: true

  alias GraphiQLImages.User.GalleryImages

  @base_url "/api/graphql"

  @mutation """
  mutation userUpdate($id: ID!, $input: UpdateUserInput!) {
    userUpdate(id: $id, input: $input) {
      name
      gallery {
        id
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

  describe "update user mutation" do
    defp variables do
      user =
        insert(:user)
        |> Map.from_struct()

      %{
        id: user.id,
        email: user.email,
        name: user.name,
        surname: user.surname
      }
    end

    @tag :normal
    test "update an user w/valid session, giving right id and params" do
      user = variables()

      response =
        post(build_conn(), @base_url, %{
          query: @mutation,
          variables: %{
            "id" => user.id,
            "input" => %{
              gallery: [],
              name: "test"
            }
          }
        })

      assert %{
               "data" => %{
                 "userUpdate" => %{
                   "name" => "test",
                   "gallery" => []
                 }
               }
             } == json_response(response, 200)
    end

    @tag :normal
    test "update an user w/valid session, giving right id and params, and images" do
      user = variables()

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

      test_image_2 = upload_image_file()

      response =
        post(build_conn(), @base_url, %{
          query: @mutation_create_image,
          variables: %{
            "gallery_image" => "test"
          },
          test: test_image_2
        })

      assert %{
               "data" => %{
                 "user_gallery_image_create" => %{"id" => id_2}
               }
             } = json_response(response, 200)

      response =
        post(build_conn(), @base_url, %{
          query: @mutation,
          variables: %{
            "id" => user.id,
            "input" => %{
              gallery: [id, id_2]
            }
          }
        })

      assert %{
               "data" => %{
                 "userUpdate" => %{
                   "name" => _,
                   "gallery" => [
                     %{
                       "galleryImage" => %{
                         "small" => _
                       }
                     },
                     %{
                       "galleryImage" => %{
                         "small" => _
                       }
                     }
                   ]
                 }
               }
             } = json_response(response, 200)

      response =
        post(build_conn(), @base_url, %{
          query: @mutation,
          variables: %{
            "id" => user.id,
            "input" => %{
              gallery: [id_2]
            }
          }
        })

      assert %{
               "data" => %{
                 "userUpdate" => %{
                   "name" => _,
                   "gallery" => [
                     %{
                       "galleryImage" => %{
                         "small" => _
                       }
                     }
                   ]
                 }
               }
             } = json_response(response, 200)

      assert GalleryImages.get_by_id(id) == nil
    end
  end
end
