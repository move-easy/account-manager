defmodule AccountManagerWeb.FallbackController do
  use AccountManagerWeb, :controller

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: AccountManagerWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
