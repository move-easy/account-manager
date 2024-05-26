defmodule AccountManager.Users.User do
  @moduledoc false

  alias AccountManager.Accounts.History
  alias AccountManager.Users.Address

  use Ecto.Schema
  import Ecto.Changeset

  @requered_fields ~w(
    username
    document
    phone
    age
    email
    password)a

  @profile ~w(admin user)a

  schema "users" do
    field :username, :string
    field :document, :string
    field :phone, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :profile, :string, default: "user"
    field :is_active, :boolean, default: true

    has_many :addresses, Address
    has_many :history, History

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @requered_fields)
    |> validate_required(@requered_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:document)
    |> validate_length(:username, min: 4, max: 50)
    |> validate_length(:document, min: 11)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> validate_inclusion(:profile, @profile)
    |> add_password_hash()
  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end

  defp add_password_hash(changeset), do: changeset
end
