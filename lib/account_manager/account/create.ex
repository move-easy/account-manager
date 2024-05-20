defmodule AccountManager.Account.Create do
  @moduledoc """
  Create a new account of user
    Example:
      iex> AccountManager.Account.Create.call(%{
        address: %{state_acronym: "ES", zip_code: "29102347"},
        document: "12355667899",
        email: "test@test.com",
        is_active: true,
        password: "123456",
        phone: "27999999999",
        profile: "admin",
        username: "oteixeiras"
        }
      )

    return:
      {
        :ok,
        %AccountManager.Account.Address{
          __meta__: #Ecto.Schema.Metadata<:loaded, "addresses">,
          id: 1,
          zip_code: "29102347",
          state_acronym: "ES",
          user_id: 3,
          user: #Ecto.Association.NotLoaded<association :user is not loaded>,
          inserted_at: ~N[2024-05-20 03:46:57],
          updated_at: ~N[2024-05-20 03:46:57]
        }
      }
  """
  alias AccountManager.Account.{User, Address, State}
  alias AccountManager.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> case do
      {:ok, user} -> create_address(user, params)
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp create_address(%AccountManager.Account.User{id: user_id}, %{address: address}) do
    address
    |> Map.put(:user_id, user_id)
    |> Address.changeset()
    |> Repo.insert()
  end
end
