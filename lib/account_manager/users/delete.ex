defmodule AccountManager.Users.Delete do
  @moduledoc false

  alias AccountManager.Repo
  alias AccountManager.Users.User

  def call(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end
end
