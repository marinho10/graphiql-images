defmodule GraphiQLImagesGraphQL.General.Types do
  @moduledoc """
  The general types.
  """
  use Absinthe.Schema.Notation

  ###########
  # Objects #
  ###########

  @desc "The timestamp object"
  object :timestamps do
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  @desc "The image object"
  object(:file_image) do
    field(:small, :string)
    field(:original, :string)
  end
end
