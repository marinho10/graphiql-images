defmodule GraphiQLImages.Factory do
  @moduledoc """
  Factory (ExMachina)
  """
  use ExMachina.Ecto, repo: GraphiQLImages.Repo

  alias GraphiQLImages.User

  # This is a sample factory to make sure our setup is working correctly.
  def name_factory(_) do
    Faker.Person.name()
  end

  def user_factory do
    %User{
      email: sequence(:user_email, &"user-email-#{&1}@coletiv.com"),
      name: sequence(:user_name, &"Name #{&1}"),
      surname: sequence(:user_surname, &"Surname #{&1}")
    }
  end
end
