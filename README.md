# DisposableEmailBlacklist

A simple library that lets you validate emails against a blacklist. The blacklist data is based on the list from [disposable-email-domains](https://github.com/martenson/disposable-email-domains)

## Installation

Add `disposable_email_blacklist` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:disposable_email_blacklist, "~> 0.1.0"}
  ]
end
```

## Usage
```elixir
iex> DisposableEmailBlacklist.valid?("my_email@gmail.com")
true

iex> DisposableEmailBlacklist.valid?("my_email@mailinator.com")
false
```

```elixir
iex> custom_blacklist = ["hammermail.tk", "blastmail.org"]

iex> DisposableEmailBlacklist.valid?("my_email@hammermail.tk", custom_blacklist)
false

iex> DisposableEmailBlacklist.valid?("my_email@gmail.com", custom_blacklist)
true
```

### Best Practice

```elixir
def changeset(%User{} = user, attrs \\ %{}) do
  user
  |> cast(attrs, [:email, :username])
  |> validate_required([:email, :username])
  |> validate_format(:email, ~r/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  |> validate_email()
end

defp validate_email(%{valid?: true, changes: %{email: email}} = changeset) do
  if DisposableEmailBlacklist.valid?(email) do
    changeset
  else
    add_error(changeset, :email, "Invalid email.")
  end
end

defp validate_email(changeset), do: changeset
```

The docs can be found at [https://hexdocs.pm/disposable_email_blacklist](https://hexdocs.pm/disposable_email_blacklist).
