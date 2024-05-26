defmodule AccountManagerWeb.AuthPlug do
  @moduledoc false

  import Plug.Conn

  use AccountManagerWeb, :controller

  alias AccountManager.Users
  alias AccountManagerWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{email: email, profile: profile, is_active: is_active}} <- Token.verify(token),
         {:ok, _user} <- Users.get(email) do
      assign(conn, :current_user, %{email: email, profile: profile, is_active: is_active})
    else
      _error -> handle_unauthorized(conn)
    end
  end

  defp handle_unauthorized(conn) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: AccountManagerWeb.ErrorJSON)
    |> render(:error, status: :unauthorized)
    |> halt()
  end
end
