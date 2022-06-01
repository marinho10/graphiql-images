defmodule GraphiQLImagesGraphQl.Middleware.Errors do
  @moduledoc """
  The Errors middleware
  It will catch changeset and other `{:error, error}` and
  display them correctly to the caller.
  """
  alias GraphiQLImages.General.Responses

  @behaviour Absinthe.Middleware
  def call(%{errors: [%Ecto.Changeset{} = changeset]} = resolution, _) do
    errors =
      changeset
      |> Ecto.Changeset.traverse_errors(&format_error/1)
      |> error_messages()

    %{
      resolution
      | errors: errors
    }
  end

  def call(%{errors: [code]} = resolution, _) do
    %{
      resolution
      | errors: [format_message(code)]
    }
  end

  def call(%{value: nil} = resolution, _) do
    %{
      resolution
      | errors: [format_message("not_found")]
    }
  end

  def call(resolution, _) do
    resolution
  end

  # Format

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end

  defp format_message(code), do: Responses.get(code)

  # Extract error message recursively

  defp error_messages(errors_map) do
    Enum.reduce(errors_map, [], fn error, acc ->
      acc ++ extract_error(error)
    end)
    |> List.flatten()
  end

  defp extract_error(errors) when is_list(errors) do
    Enum.map(errors, &format_message(&1))
  end

  defp extract_error({_, errors}) when is_list(errors) do
    Enum.map(errors, &format_message(&1))
  end

  defp extract_error({_, errors}) when is_map(errors) do
    Enum.map(errors, fn {_field, value} ->
      extract_error(value)
    end)
  end
end
