defmodule AccountManagerWeb.UsersController do
  use AccountManagerWeb, :controller

  alias AccountManager.Users
  alias AccountManager.Users.User

  action_fallback AccountManagerWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
end
