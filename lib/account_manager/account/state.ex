defmodule AccountManager.Account.State do
  @moduledoc """
  State schema
    Example:
      iex> State.changeset(%{region: "Norte", state_name: "Acre"})

      return:
        #Ecto.Changeset<
          action: nil,
          changes: %{
            region: "Norte",
            state_name: "Acre",
            country: "Brasil"
          },
          errors: [],
          data: #AccountManager.Account.State<>,
          valid?: true
        >
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias AccountManager.Account.Address

  @required_fields [:region, :state_name]
  @optional_fields [:country]

  schema "states" do
    field :region, :string
    field :state_name, :string
    field :country, :string, default: "Brasil"

    has_many :adresses, Address

    timestamps()
  end

  def changeset(state \\ %__MODULE__{}, attrs) do
    state
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
