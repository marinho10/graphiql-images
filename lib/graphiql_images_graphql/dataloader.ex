defmodule GraphiQLImagesGraphQl.Dataloader do
  @moduledoc """
  Dataloader source
  """
  import Ecto.Query, warn: false

  alias GraphiQLImages.Repo

  ### DATALOADER

  @doc """
  Dataloader source
  """
  def data, do: Dataloader.Ecto.new(Repo, query: &query/2)

  @doc """
  Dataloader query
  """
  def query(queryable, _params), do: queryable

  @doc """
  reduce function
  """
  def apply_param({:order, {:asc, field}}, queryable),
    do: queryable |> order_by(asc: ^field)

  def apply_param({:order, {:desc, field}}, queryable),
    do: queryable |> order_by(desc: ^field)

  def apply_param({:order, field}, queryable),
    do: queryable |> order_by(asc: ^field)

  def apply_param({:id, id}, queryable),
    do: queryable |> where(id: ^id)

  def apply_param(_param, queryable), do: queryable
end
