# GraphiQLImages Project

## 🚧 Dependencies

- Elixir (`~> 1.13`)
- Erlang (`~> 24.0`)
- PostgreSQL (`~> 13.0`)

## 🏎 Kickstart

### Environment variables

We are not using many environemnt variables for now, meaning you have to manually create the `*.secret.exs` files and add them to the server or injecting variables somehow.

### Initial setup

1. Install Mix dependencies with `mix deps.get`
2. Create and migrate the database with `mix ecto.setup`
3. Start the Phoenix server with `iex -S mix phx.server`

### Code Quality

Several linting, formatting tools and security checks can be ran to ensure coding style consistency:

- `mix check.linter` ensures Elixir code follows our guidelines and best practices
- `mix check.code.security` scan
- `mix check.code.format` ensures all code is properly formatted
- `mix format` formats files

### Tests

Tests can be ran with `mix test` and test coverage can be calculated with `mix check.code.coverage`.

