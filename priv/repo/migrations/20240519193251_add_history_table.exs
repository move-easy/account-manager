defmodule AccountManager.Repo.Migrations.AddHistoryTable do
  use Ecto.Migration

  def change do
    create table("history") do
      add :user_id, references("users", on_delete: :delete_all, type: :id), null: false

      add :zip_code, :string, null: false
      add :is_favorite, :boolean, default: false

      timestamps()
    end
  end
end
