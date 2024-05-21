defmodule AccountManagerWeb.UsersController do
  use AccountManagerWeb, :controller

  alias AccountManager.Users
  alias AccountManager.Users.User
  alias AccountManagerWeb.Token

  action_fallback AccountManagerWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params),
         {:ok, token} <- Token.sign(user) do
      conn
      |> put_status(:created)
      |> render(:create, user: user, token: token)
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
