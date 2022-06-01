defmodule GraphiQLImages.User.GalleryImage.Process.ImageCleanWorkerTest do
  @moduledoc """
  MonthStatsWorkerTest
  """
  import Ecto.Query, warn: false
  use GraphiQLImagesWeb.ConnCase, async: true

  alias GraphiQLImages.General.Clock
  alias GraphiQLImages.Repo
  alias GraphiQLImages.User.GalleryImage.Process.ImageCleanWorker
  alias GraphiQLImages.User.GalleryImages

  @base_url "/api/graphql"

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

  describe "ImageCleanWorkerTest" do
    @tag :normal
    test "init()" do
      assert {:ok, %{}} = ImageCleanWorker.init(%{})
    end

    @tag :normal
    test "run ImageCleanWorker" do
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

      assert %{id: _} = GalleryImages.get_by_id(id)

      time = Timex.shift(Clock.now(), months: -2)

      Ecto.Changeset.cast(
        GalleryImages.get_by_id(id),
        %{inserted_at: time},
        [
          :inserted_at
        ]
      )
      |> Repo.update()

      assert {:noreply, %{}} = ImageCleanWorker.handle_info(:run_image_clean_worker, %{})

      assert is_nil(GalleryImages.get_by_id(id))
    end
  end
end
