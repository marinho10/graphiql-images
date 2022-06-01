defmodule GraphiQLImages.General.GeneralQuery do
  @moduledoc """
  General queries used in different places of the app
  """

  import Ecto.Query, warn: false

  @doc """
  Sorts the results by the sort_field following the sort_order.
  If no value is passed on sort_order, defaults to `:asc`.

  Returns `Ecto.Query<>`

  ## Examples

    iex> GraphiQLImages.General.Query.sort_by(query, :field_1, :asc)
    Ecto.Query<from m0 in Module, order_by: [asc: :field_1]>

    iex> GraphiQLImages.General.Query.sort_by(query, :field_1, :asc_nulls_last)
    Ecto.Query<from m0 in Module, order_by: [asc_nulls_last: :field_1]>

    iex> GraphiQLImages.General.Query.sort_by(query, :field_1, :asc_nulls_first)
    Ecto.Query<from m0 in Module, order_by: [asc_nulls_first: :field_1]>

    iex> GraphiQLImages.General.Query.sort_by(query, :field_1, :desc)
    Ecto.Query<from m0 in Module, order_by: [desc: :field_1]>

    iex> GraphiQLImages.General.Query.sort_by(query, :field_1, :desc_nulls_last)
    Ecto.Query<from m0 in Module, order_by: [desc_nulls_last: :field_1]>

    iex> GraphiQLImages.General.Query.sort_by(query, :field_1, :desc_nulls_first)
    Ecto.Query<from m0 in Module, order_by: [desc_nulls_first: :field_1]>

    iex> GraphiQLImages.General.Query.sort_by(query, _, _)
    Ecto.Query<from m0 in Module...>

  """
  def sort_by(query, field, direction \\ :asc)
  def sort_by(query, nil, _), do: query
  def sort_by(query, field, :asc), do: order_by(query, [q], asc: ^field)
  def sort_by(query, field, :asc_nulls_last), do: order_by(query, [q], asc_nulls_last: ^field)
  def sort_by(query, field, :asc_nulls_first), do: order_by(query, [q], asc_nulls_first: ^field)
  def sort_by(query, field, :desc), do: order_by(query, [q], desc: ^field)
  def sort_by(query, field, :desc_nulls_last), do: order_by(query, [q], desc_nulls_last: ^field)
  def sort_by(query, field, :desc_nulls_first), do: order_by(query, [q], desc_nulls_first: ^field)
  def sort_by(query, _, _), do: order_by(query, [q], desc: q.inserted_at)

  @doc """

  Preload results with fields

  Returns `Ecto.Query<>`

  ## Examples

    iex> GraphiQLImages.General.Query.preload_by(query, [:field])
    Ecto.Query<from m0 in Module...>

    iex> GraphiQLImages.General.Query.preload_by(query, nil)
    Ecto.Query<from m0 in Module...>

    iex> GraphiQLImages.General.Query.preload_by(query, [])
    Ecto.Query<from m0 in Module...>
  """
  def preload_by(query, fields)
  def preload_by(query, nil), do: query
  def preload_by(query, []), do: query
  def preload_by(query, fields), do: query |> preload(^fields)
end
