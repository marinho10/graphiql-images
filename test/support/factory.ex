defmodule GraphiQLImages.Factory do
  @moduledoc """
  Factory (ExMachina)
  """
  use ExMachina.Ecto, repo: GraphiQLImages.Repo

  # This is a sample factory to make sure our setup is working correctly.
  def name_factory(_) do
    Faker.Person.name()
  end
end
