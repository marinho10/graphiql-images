defmodule GraphiQLImages.General.Responses do
  @moduledoc """
  List of all possible responses from the API
  """

  @doc """
  Return error response (right format)
  """
  def get(response) when is_binary(response) do
    %{
      extensions: %{
        code: get_code(response),
        timestamp: get_timestamp()
      },
      message: get_message(response)
    }
  end

  def get(_) do
    %{
      extensions: %{
        code: "INTERNAL_ERROR",
        timestamp: get_timestamp()
      },
      message: "Internal error"
    }
  end

  @doc """
  Get timestamp for errors
  """
  def get_timestamp,
    do: DateTime.utc_now() |> DateTime.to_iso8601()

  # Code
  defp get_code(response),
    do: String.upcase(to_string(response))

  # Message

  defp get_message("not_found"),
    do: "Resource not found"

  defp get_message("field_is_required"),
    do: "Field is required"

  defp get_message("email_has_been_taken"),
    do: "Email has already been taken"

  defp get_message("invalid_email_format"),
    do: "Invalid email format"

  defp get_message(_), do: nil
end
