defmodule GraphiQLImages.Schema do
  @moduledoc """
  An extension to the default `Ecto.Schema` that changes
  by default the incremental id to a binary generated id,
  avoiding the repetition on every schema.
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
