defmodule AccountManager.Users do
  @doc """
  """
  alias AccountManager.Users.Create
  alias AccountManager.Users.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(email), to: Get, as: :call
end
