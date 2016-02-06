defmodule Community.Repo.Migrations.CreateJob do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string, null: false
      add :company, :string, null: false
      add :city, :string, null: false
      add :company_url, :string, null: false
      add :description, :text, null: false
      add :instructions, :text, null: false
      add :approved, :boolean, default: false, null: false
      add :preview, :boolean, default: true, null: false

      timestamps
    end

  end
end
