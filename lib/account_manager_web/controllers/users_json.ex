defmodule AccountManagerWeb.UsersJSON do
  alias AccountManager.Users.User

  def create(%{user: user}, token) do
    %{
      message: "User created",
      data: data(user, token)
    }
  end

  def show(%{user: user}) do
    %{
      message: "User found",
      data: data(user)
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email
    }
  end

  defp data(%User{} = user, token) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end
end
