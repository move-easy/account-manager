defmodule AccountManager.Users.Get do
  @moduledoc """
  Get user by id
  """
  alias AccountManager.Repo
  alias AccountManager.Users.User

  def call(email) do
    case Repo.get(User, email) do
      nil -> {:error, :not_found}
      user -> {:ok, user |> Repo.preload([:addresses])}
    end
  end
end
