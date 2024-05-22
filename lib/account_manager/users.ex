defmodule AccountManager.Users do
  @moduledoc false

  alias AccountManager.Users.Create
  alias AccountManager.Users.Get
  alias AccountManager.Verify

  defdelegate create(params), to: Create, as: :call
  defdelegate get(email), to: Get, as: :call
  defdelegate login(params), to: Verify, as: :call
end
