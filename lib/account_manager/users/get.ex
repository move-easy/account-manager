defmodule AccountManager.Users.Get do
  @moduledoc """
  Get user by id
  """
  alias AccountManager.Repo
  alias AccountManager.Users.User

  def call(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
