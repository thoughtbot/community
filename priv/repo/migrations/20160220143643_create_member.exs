defmodule Community.Repo.Migrations.CreateMember do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :company_name, :string, null: false
      add :approved, :boolean, default: false, null: false

      timestamps()
    end

  end
end
