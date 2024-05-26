defmodule AccountManagerWeb.ErrorJSON do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on JSON requests.

  See config/config.exs.
  """

  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns), do: %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}

  def error(%{status: :not_found}), do: message_error("Resource not found")

  def error(%{status: :unauthorized}), do: message_error("Unauthorized")

  def error(%{status: :method_not_allowed}), do: message_error("Method not allowed")

  def error(%{changeset: changeset}), do: %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_errors/1)}

  defp translate_errors({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
    end)
  end

  def message_error(message),
    do: %{
      erros: %{
        message: message
      }
    }
end
