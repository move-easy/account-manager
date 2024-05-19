defmodule AccountManager.Repo.Migrations.AddStatesTable do
  use Ecto.Migration

  def change do
    create table("states") do
      add :region, :string, null: false, unique: true
      add :state_name, :string, null: false, unique: true
      add :country, :string, default: "Brasil"

      timestamps()
    end
  end
end
