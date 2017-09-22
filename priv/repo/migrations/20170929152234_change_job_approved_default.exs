defmodule Community.Repo.Migrations.ChangeJobApprovedDefault do
  use Ecto.Migration

  def up do
    alter table(:jobs) do
      modify :approved, :boolean, default: true, null: false
    end
  end

  def down do
    alter table(:jobs) do
      modify :approved, :boolean, default: false, null: false
    end
  end
end
