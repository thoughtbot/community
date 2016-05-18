defmodule Community.Repo.Migrations.AddAvailableForHireToMember do
  use Ecto.Migration

  def change do
    alter table(:members) do
      add :available_for_hire, :boolean, null: false, default: false
    end
  end
end
