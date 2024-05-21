defmodule AccountManager.Users do
  @doc """
  """
  alias AccountManager.Users.{Create, Get}

  defdelegate create(params), to: Create, as: :call

  defdelegate show(params), to: Get, as: :call
end
