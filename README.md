# GraphiQLImages

![](https://github.com/<ORGANIZATION_NAME/<REPOSITORY_NAME>/workflows/Continuous%20Integration%20Staging/badge.svg)
![](https://github.com/<ORGANIZATION_NAME/<REPOSITORY_NAME>/workflows/Continuous%20Deployment%20Staging/badge.svg)

![](https://github.com/<ORGANIZATION_NAME/<REPOSITORY_NAME>/workflows/Continuous%20Integration%20Production/badge.svg)
![](https://github.com/<ORGANIZATION_NAME/<REPOSITORY_NAME>/workflows/Continuous%20Deployment%20Production/badge.svg)

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

### AWS Alarms

Please pay attention and if necessary we should create alarms associated with EC2 instance (CPU, memory, etc ...).

### Github Actions

Change environment variables on the workflow file to reflect the project's variables (app name, etc).

### Testing Level

- [ ] First Level (Endpoint)
- [ ] Second Level (Model)
- [ ] Third Level (Integration)

## GraphQL Schema Nomenclature

### Queries

- Example `<entity>` for one element (entity shop)

```graphql
query {
  shop {
    id
    name
    email
  }
}
```

- Example `<entities>` for list elements (entity shop)

```graphql
query(page: Integer!, pageSize: Integer!) {
  shops(page: $page, pageSize: $pageSize) {
    entries {
      id
      name
      email
    }
  }
}
```

### Mutations

- Example `<entity>_<action>` (entity shop, action edit)

```graphql
mutation ($id: ID!, $input: ShopEditInput!) {
  shopEdit(id: $id, input: $input) {
    id
    name
    email
  }
}
```

Any doubts follow the [Shopify concept](https://shopify.dev/concepts/graphql/).
