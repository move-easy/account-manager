defmodule AccountManagerWeb.Token do
  @moduledoc false

  alias AccountManager.Users.User
  alias AccountManagerWeb.Endpoint

  alias Phoenix.Token

  @sign_salt "account_manager_api"
  # 24 hours
  @ttl 86_400

  def sign(%User{} = user) do
    {:ok,
     Token.sign(Endpoint, @sign_salt, %{
       email: user.email,
       profile: user.profile,
       is_active: user.is_active
     })}
  end

  def verify(token) do
    Endpoint
    |> Token.verify(@sign_salt, token, max_age: @ttl)
    |> case do
      {:ok, _data} = response -> response
      {:error, _reason} -> {:error, :unauthorized}
    end
  end
end
