defmodule Community.Repo.Migrations.ChangeMemberApprovedDefault do
  use Ecto.Migration

  def up do
    alter table(:members) do
      modify :approved, :boolean, default: true, null: false
    end
  end

  def down do
    alter table(:members) do
      modify :approved, :boolean, default: false, null: false
    end
  end
end
