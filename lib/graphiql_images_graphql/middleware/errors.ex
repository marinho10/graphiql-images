defmodule GraphiQLImagesGraphQL.Middleware.Errors do
  @moduledoc """
  The middleware errors.
  """
  alias GraphiQLImages.General.Responses

  @behaviour Absinthe.Middleware

  # Errors from changeset
  def call(%{errors: [%Ecto.Changeset{} = changeset]} = resolution, _) do
    errors =
      changeset
      |> Ecto.Changeset.traverse_errors(&format_error/1)
      |> Enum.map(fn {_field, [code]} ->
        format_message(code)
      end)

    %{
      resolution
      | errors: errors
    }
  end

  # Errors from speakeasy are already formated
  def call(
        %{
          errors: [%{extensions: _} = error]
        } = resolution,
        _
      ) do
    Map.merge(resolution, %{errors: [Map.merge(error, %{timestamp: Responses.get_timestamp()})]})
  end

  # Errors from the reguar {:error, :code} returns
  def call(%{errors: [code]} = resolution, _) do
    %{
      resolution
      | errors: [format_message(code)]
    }
  end

  # Errors from nil
  def call(%{value: nil} = resolution, _) do
    %{
      resolution
      | errors: [format_message("not_found")]
    }
  end

  # Errors fallback
  def call(resolution, _) do
    resolution
  end

  # Format message
  defp format_message(code), do: Responses.get(code)

  # Format error
  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
