defmodule AccountManager.Accounts.History do
  @moduledoc """
  History schema
    Example:
      iex(1)> AccountManager.Account.History.changeset(%{zip_code: "29102347", user_id: 1, is_favorite: true})

      return:
        #Ecto.Changeset<
            action: nil,
            changes: %{user_id: 1, is_favorite: true, zip_code: "29102347"},
            errors: [],
            data: #AccountManager.Accounts.History<>,
            valid?: true
        >

  """

  use Ecto.Schema
  import Ecto.Changeset

  alias AccountManager.Users.User

  @required_fields [:zip_code, :is_favorite, :user_id]

  schema "history" do
    field :zip_code, :string
    field :is_favorite, :boolean, default: false

    belongs_to :user, User

    timestamps()
  end

  def changeset(history \\ %__MODULE__{}, attrs) do
    history
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:zip_code, is: 8)
  end
end
