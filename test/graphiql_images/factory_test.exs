defmodule GraphiQLImages.FactoryTest do
  @moduledoc """
  This is a test module to make sure our factory setup is working correctly.
  You’ll probably want to delete it.
  """

  use GraphiQLImages.DataCase, async: true

  import GraphiQLImages.Factory

  @tag :normal
  test "build/1 name works with our factory setup" do
    assert is_binary(build(:name))
  end

  @tag :normal
  test "build/1 user works with our factory setup" do
    assert %{} = build(:user)
  end
end
