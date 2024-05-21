defmodule AccountManagerWeb.Token do
  alias AccountManagerWeb.Endpoint

  alias Phoenix.Token

  @sign_salt "account_manager_api"

  def sign(user) do
    {:ok,
     Token.sign(Endpoint, @sign_salt, %{
       user_id: user.id,
       email: user.email,
       profile: user.profile,
       is_active: user.is_active,
       document: user.document
     })}
  end

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
