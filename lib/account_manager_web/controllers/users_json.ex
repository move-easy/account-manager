defmodule AccountManagerWeb.UsersJSON do
  alias AccountManager.Users.User

  def create(%{user: user}) do
    %{
      message: "User created",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      token: "xpto"
    }
  end
end
