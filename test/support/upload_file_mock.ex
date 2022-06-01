defmodule GraphiQLImages.UploadFileMock do
  @moduledoc """
  Upload File Mock
  """

  def upload_image_file, do: %Plug.Upload{path: "test/assets/test.jpg", filename: "test.jpg"}
end
