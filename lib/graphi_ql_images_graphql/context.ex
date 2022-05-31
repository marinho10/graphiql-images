defmodule GraphiQLImagesGraphQL.Context do
  @moduledoc """
  GraphQL Context
  """
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _), do: put_private(conn, :absinthe, %{context: build_context(conn)})

  defp build_context(_conn), do: %{}
end
