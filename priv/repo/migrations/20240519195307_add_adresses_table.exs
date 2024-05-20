defmodule AccountManager.Repo.Migrations.AddAdressesTable do
  use Ecto.Migration

  def change do
    create table("adresses") do
      add :user_id, references("users", on_delete: :delete_all, type: :id), null: false
      add :state_id, references("states", on_delete: :delete_all, type: :id), null: false

      add :zip_code, :string, null: false

      timestamps()
    end
  end
end
