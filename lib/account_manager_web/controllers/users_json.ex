defmodule AccountManagerWeb.UsersJSON do
  alias AccountManager.Users.User

  def create(%{user: user, token: token}) do
    %{
      message: "User created",
      data: data(user, token)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email
    }
  end

  defp data(%User{} = user, token) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      access_token: token
    }
  end
end
