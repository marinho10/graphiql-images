defmodule GraphiQLImagesGraphQl.User.GalleryImage.Mutations.UserGalleryImageCreateTest do
  @moduledoc """
  Tests GraphQl user_gallery_image_create
  """
  use GraphiQLImagesWeb.ConnCase, async: true

  @base_url "/api/graphql"

  @mutation """
  mutation user_gallery_image_create($gallery_image: Upload!) {
    user_gallery_image_create(gallery_image: $gallery_image) {
      galleryImage {
        small
      }
    }
  }
  """

  describe "user_gallery_image_create mutation" do
    @tag :normal
    test "create an image, giving right params" do
      test_image = upload_image_file()

      response =
        post(build_conn(), @base_url, %{
          query: @mutation,
          variables: %{
            "gallery_image" => "test"
          },
          test: test_image
        })

      assert %{
               "data" => %{
                 "user_gallery_image_create" => %{"galleryImage" => %{"small" => _}}
               }
             } = json_response(response, 200)
    end
  end
end
