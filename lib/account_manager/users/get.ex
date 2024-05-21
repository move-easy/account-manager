defmodule AccountManager.Users.Get do
  @moduledoc """
  Get user by id
  """
  alias AccountManager.Repo
  alias AccountManager.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user |> Repo.preload([:addresses, :accounts])}
    end
  end
end
