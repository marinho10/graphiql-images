defmodule GraphiQLImagesGraphQL.General.Types do
  @moduledoc """
  The general types.
  """
  use Absinthe.Schema.Notation

  #
  # Input Objects
  #

  input_object :pagination_input do
    field :page, non_null(:integer)
    field :page_size, non_null(:integer)
  end

  #
  # Objects
  #

  @desc "The timestamp object"
  object :timestamps do
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  @desc "The pagination object"
  object :pagination do
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer
  end

  #
  # Enums
  #

  enum :sort_directions do
    value(:asc)
    value(:asc_nulls_last)
    value(:asc_nulls_first)
    value(:desc)
    value(:desc_nulls_last)
    value(:desc_nulls_first)
  end
end
