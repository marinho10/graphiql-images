defmodule GraphiQLImages.Repo do
  use Ecto.Repo,
    otp_app: :graphiql_images,
    adapter: Ecto.Adapters.Postgres
end
