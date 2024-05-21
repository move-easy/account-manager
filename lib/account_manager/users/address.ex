defmodule AccountManager.Users.Address do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias AccountManager.Users.User

  @required_fields [:user_id, :zip_code, :state_acronym]
  @states_valids ~w(
    ES
    MG
    SP
    RJ
    BA
    RS
    SC
    PR
    GO
    DF
    MS
    MT
    RO
    AC
    AM
    RR
    PA
    AP
    TO
    MA
    PI
    CE
    RN
    PB
    PE
    AL
    SE
  )

  schema "addresses" do
    field :zip_code, :string
    field :state_acronym, :string

    belongs_to :user, User

    timestamps()
  end

  def changeset(address \\ %__MODULE__{}, attrs) do
    address
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:zip_code, is: 8)
    |> validate_inclusion(:state_acronym, @states_valids)
  end
end
