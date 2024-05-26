defmodule AccountManagerWeb.UsersJSON do
  @moduledoc false

  alias AccountManager.Users.User

  def create(%{user: user, token: token}), do: %{data: data(user, token, "User created successfully!")}

  def delete(%{user: user}), do: %{data: data(user, "User deleted successfully!")}

  def login(%{user: user, token: token}), do: %{data: data(user, token, "User authenticated successfully!")}

  def get(%{user: user}), do: %{data: data(user, "User retrieved successfully!")}

  defp data(%User{} = user, message),
    do: %{
      profile: user.profile,
      username: user.username,
      email: user.email,
      is_active: user.is_active,
      message: message
    }

  defp data(%User{} = user, token, message),
    do: %{
      profile: user.profile,
      username: user.username,
      email: user.email,
      is_active: user.is_active,
      access_token: token,
      message: message
    }
end
