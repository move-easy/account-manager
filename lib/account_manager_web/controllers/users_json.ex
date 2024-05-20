defmodule AccountManagerWeb.UsersJSON do
  alias AccountManager.Users.User

  def create(%{user: user}) do
    %{
      message: "User created",
      data: data(user)
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      token: "xpto"
    }
  end
end
