defmodule GraphiQLImages.ResponsesTest do
  @moduledoc """
  This is a test module to make sure our factory setup is working correctly.
  You’ll probably want to delete it.
  """

  use GraphiQLImages.DataCase, async: true

  alias GraphiQLImages.General.Responses

  @tag :normal
  test "not_found response" do
    assert %{
             extensions: %{code: "NOT_FOUND", timestamp: _},
             message: "Resource not found"
           } = Responses.get("not_found")
  end

  @tag :normal
  test "invalid_email_format response" do
    assert %{
             extensions: %{code: "INVALID_EMAIL_FORMAT", timestamp: _},
             message: "Invalid email format"
           } = Responses.get("invalid_email_format")
  end

  @tag :normal
  test "email_has_been_taken response" do
    assert %{
             extensions: %{code: "EMAIL_HAS_BEEN_TAKEN", timestamp: _},
             message: "Email has already been taken"
           } = Responses.get("email_has_been_taken")
  end

  @tag :normal
  test "field_is_required response" do
    assert %{
             extensions: %{code: "FIELD_IS_REQUIRED", timestamp: _},
             message: "Field is required"
           } = Responses.get("field_is_required")
  end
end
