defmodule Community.Repo.Migrations.AddUniqueIndexToMemberEmail do
  use Ecto.Migration

  def change do
    create unique_index(:members, [:email])
  end
end
