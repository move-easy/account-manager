defmodule AccountManagerWeb.FallbackController do
  @moduledoc false

  use AccountManagerWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: AccountManagerWeb.ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: AccountManagerWeb.ErrorJSON)
    |> render(:error, status: :unauthorized)
  end

  def call(conn, {:error, :method_not_allowed}) do
    conn
    |> put_status(:method_not_allowed)
    |> put_view(json: AccountManagerWeb.ErrorJSON)
    |> render(:error, status: :method_not_allowed)
  end

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: AccountManagerWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
