defmodule AuthKata.Accounts.User do
  use Ecto.Schema
  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  alias AuthKata.Accounts.User


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :encrypted_password, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> unique_constraint(:email)
  end

  def save_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :encrypted_password, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_password_and_confirmation_matches
    |> generate_password_hash
  end

  defp generate_password_hash(changeset) do
    password = get_change(changeset, :password)

    encrypted_password = Comeonin.Argon2.hashpwsalt(password)

    changeset |> put_change(:encrypted_password, encrypted_password)
  end

  defp validate_password_and_confirmation_matches(changeset) do
    password = get_change(changeset, :password)
    password_confirmation = get_change(changeset, :password_confirmation)

    if password == password_confirmation do
      changeset
    else
      changeset
        |> add_error(:password_confirmation, "Passwords don't match!")
    end
  end
end
