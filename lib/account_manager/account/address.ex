defmodule AccountManager.Account.Address do
  @moduledoc """
  Address schema
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
