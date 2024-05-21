defmodule AccountManager.Verify do
  alias AccountManager.Users

  def call(%{"email" => email, "password" => password}) do
    case Users.get(email) do
      {:ok, user} -> verify(user, password)
      {:error, _} = error -> error
    end
  end

  defp verify(user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end
