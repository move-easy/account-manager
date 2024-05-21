defmodule AccountManagerWeb.UsersController do
  use AccountManagerWeb, :controller

  alias AccountManager.Users
  alias AccountManager.Users.User

  action_fallback AccountManagerWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user, token: "XPTO")
    end
  end

  def show(conn, %{"email" => email}) do
    with {:ok, user} <- Users.show(email) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end
end
