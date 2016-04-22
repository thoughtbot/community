defmodule Community.Repo.Migrations.AddTokenToJob do
  use Ecto.Migration

  def change do
    execute "TRUNCATE TABLE jobs;"

    alter table(:jobs) do
      add :token, :uuid, null: false
    end
  end
end
