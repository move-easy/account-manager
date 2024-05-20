defmodule AccountManager.Account.History do
  @moduledoc """
  History schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias AccountManager.Account.User

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
