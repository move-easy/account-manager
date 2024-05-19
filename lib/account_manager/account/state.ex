defmodule AccountManager.Account.State do
  use Ecto.Schema
  import Ecto.Changeset

  alias AccountManager.Account.Address

  @required_fields [:region, :state_name]
  @optional_fields [:country]

  schema "states" do
    field :region, :string
    field :state_name, :string
    field :country, :string, default: "Brasil"

    has_many :address, Address

    timestamps()
  end

  def changeset(state \\ %__MODULE__{}, attrs) do
    state
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
