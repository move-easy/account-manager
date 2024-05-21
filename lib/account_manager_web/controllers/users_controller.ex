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

  def show(conn, %{"email" => email}) do
    with {:ok, %User{} = user} <- Users.get(email) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end
end
