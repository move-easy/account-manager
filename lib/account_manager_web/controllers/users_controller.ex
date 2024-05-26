defmodule AccountManagerWeb.UsersController do
  @moduledoc false

  use AccountManagerWeb, :controller

  alias AccountManager.Users
  alias AccountManager.Users.User
  alias AccountManagerWeb.FallbackController
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

  def delete(conn, params) do
    with email_user <- Map.get(params, "email"), {:ok, %User{} = user} <- Users.get(email_user) do
      {:ok, current_email} =
        get_current_email(conn)

      case email_user == current_email do
        false ->
          Users.delete(email_user)

          conn
          |> put_status(:ok)
          |> render(:delete, user: user)

        true ->
          conn
          |> FallbackController.call({:error, :method_not_allowed})
      end
    end
  end

  def show(conn, params) do
    with {:ok, email} <- handle_get_email(conn, params),
         {:ok, %User{} = user} <- Users.get(email) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end

  def login(conn, params) do
    with {:ok, %User{} = user} <- Users.login(params) do
      {:ok, token} = Token.sign(user)

      conn
      |> put_status(:ok)
      |> render(:login, user: user, token: token)
    end
  end

  defp handle_get_email(conn, params) do
    case Map.get(params, "email", nil) do
      nil -> get_current_email(conn)
      email -> {:ok, email}
    end
  end

  defp get_current_email(conn), do: {:ok, conn.assigns.current_user.email}
end
