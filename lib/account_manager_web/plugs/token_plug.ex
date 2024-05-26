defmodule AccountManagerWeb.TokenPlug do
  @moduledoc false

  import Plug.Conn

  use AccountManagerWeb, :controller

  @token_access "SFMyNTY"

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
      case token == @token_access do
        true ->
          assign(conn, :current_user, %{email: "token@default", profile: "token-default", is_active: "token-default"})

        false ->
          handle_unauthorized(conn)
      end
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
