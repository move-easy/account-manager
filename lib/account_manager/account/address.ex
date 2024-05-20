defmodule AccountManager.Account.Address do
  @moduledoc """
  Address schema
    Example:
      iex(1)> AccountManager.Account.Address.changeset(%{zip_code: "29102347", user_id: 1, state_id: 1})

      return:
      #Ecto.Changeset<
        action: nil,
        changes: %{state_id: 1, user_id: 1, zip_code: "29102347"},
        errors: [],
        data: #AccountManager.Account.Address<>,
        valid?: true
      >
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias AccountManager.Account.{User, State}

  @required_fields [:user_id, :state_id, :zip_code]

  schema "address" do
    field :zip_code, :string

    belongs_to :user, User
    belongs_to :state, State

    timestamps()
  end

  def changeset(adress \\ %__MODULE__{}, attrs) do
    adress
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:zip_code, is: 8)
  end
end
