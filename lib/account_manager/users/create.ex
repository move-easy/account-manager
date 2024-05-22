defmodule AccountManager.Users.Create do
  @moduledoc false

  alias AccountManager.Users.Address
  alias AccountManager.Users.User
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

  defp create_address(user, params) do
    params
    |> Map.put("user_id", user.id)
    |> Address.changeset()
    |> Repo.insert()
    |> case do
      {:ok, _address} -> {:ok, user}
      {:error, changeset} -> {:error, changeset}
    end
  end
end
