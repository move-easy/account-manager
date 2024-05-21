defmodule AccountManager.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :username, :string, size: 50, null: false
      add :document, :string
      add :phone, :string, size: 15
      add :age, :integer
      add :email, :string, size: 100, null: false
      add :password_hash, :string, null: false
      add :profile, :string, null: false
      add :is_active, :boolean, default: true

      timestamps()
    end

    create unique_index("users", :email)
    create unique_index("users", :document)
  end
end
