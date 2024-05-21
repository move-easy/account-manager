defmodule AccountManager.Users do
  @doc """
  """
  alias AccountManager.Users.Create

  defdelegate create(params), to: Create, as: :call
end
