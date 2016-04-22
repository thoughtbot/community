defmodule Community.Repo.Migrations.AddContactToJob do
  use Ecto.Migration

  def change do
    execute "TRUNCATE TABLE jobs;"

    alter table(:jobs) do
      add :contact, :string, null: false
    end
  end
end
