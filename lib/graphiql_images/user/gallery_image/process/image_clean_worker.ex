defmodule GraphiQLImages.User.GalleryImage.Process.ImageCleanWorker do
  @moduledoc """
  Module worker to clean unused images (image inserted at least 2 days ago) from the database.
  """
  use GenServer, restart: :transient

  alias GraphiQLImages.General.Clock
  alias GraphiQLImages.User.GalleryImage.Query, as: GalleryImageQuery
  alias GraphiQLImages.User.GalleryImages

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: :image_clean_worker)
  end

  def init(state) do
    schedule()
    {:ok, state}
  end

  def handle_info(:run_image_clean_worker, state) do
    run_image_clean_worker()
    schedule()

    {:noreply, state}
  end

  # Clean unused images (image inserted at least 2 days ago) from the database and S3
  defp run_image_clean_worker do
    GalleryImageQuery.filter_by_nil_user()
    |> GalleryImageQuery.filter_by_inserted_at(Timex.shift(Clock.now(), days: -2))
    |> GalleryImages.delete()
  end

  defp schedule,
    do:
      Process.send_after(
        self(),
        :run_image_clean_worker,
        next_day_schedule_time()
      )

  defp next_day_schedule_time(schedule_hours \\ 4) do
    # ensure the next run hour is exactly the @email_sending_hour [hour]
    next_hour = 24 - DateTime.utc_now().hour + schedule_hours
    # ensure the minute is exactly 0 [ms * sec]
    next_minutes = 1000 * 60 * DateTime.utc_now().minute

    # [ms * sec * minute]
    1000 * 60 * 60 * next_hour - next_minutes
  end
end
