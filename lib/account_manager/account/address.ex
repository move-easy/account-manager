defmodule AccountManager.Account.Address do
  @moduledoc """
  Address schema
    Example:
      iex(1)> AccountManager.Account.Address.changeset(%{zip_code: "29102347", user_id: 1, state_acronym: "ES"})

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

  alias AccountManager.Account.User

  @required_fields [:user_id, :zip_code, :state_acronym]

  schema "addresses" do
    field :zip_code, :string
    field :state_acronym, :string

    belongs_to :user, User
    timestamps()
  end

  def changeset(adress \\ %__MODULE__{}, attrs) do
    adress
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:zip_code, is: 8)
    |> validate_inclusion(:state_acronym, [
      "ES",
      "MG",
      "SP",
      "RJ",
      "BA",
      "RS",
      "SC",
      "PR",
      "GO",
      "DF",
      "MS",
      "MT",
      "RO",
      "AC",
      "AM",
      "RR",
      "PA",
      "AP",
      "TO",
      "MA",
      "PI",
      "CE",
      "RN",
      "PB",
      "PE",
      "AL",
      "SE"
    ])
  end
end
