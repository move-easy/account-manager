defmodule AccountManager.Users.User do
  @moduledoc """
  User schema
    Example:
      iex> User.changeset(%{username: "oteixeiras", document: "123456", phone: "997037221", age: 18, password: "123456"})

      return:
        #Ecto.Changeset<
          action: nil,
          changes: %{
            username: "oteixeiras",
            document: "123456",
            phone: "997037221",
            age: 18
          },
          errors: [],
          data: #AccountManager.Users.User<>,
          valid?: true
        >
  """

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
    |> validate_length(:username, min: 3, max: 50)
    |> validate_length(:document, min: 11)
    |> validate_length(:email, min: 5, max: 100)
    |> validate_format(:email, ~r/@/)
    |> validate_inclusion(:profile, ["admin", "user"])
    |> add_password_hash()
  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end

  defp add_password_hash(changeset), do: changeset
end
