defmodule AccountManager.Repo.Migrations.AddAdressesTable do
  use Ecto.Migration

  def change do
    create table("addresses") do
      add :user_id, references("users", on_delete: :delete_all, type: :id), null: false

      add :zip_code, :string, null: false
      add :state_acronym, :string

      timestamps()
    end
  end
end
