defmodule Community.Repo.Migrations.AddTokenToMember do
  use Ecto.Migration

  def change do
    execute "TRUNCATE TABLE members;"

    alter table(:members) do
      add :token, :uuid, null: false
    end
  end
end
