defmodule Community.Repo.Migrations.AddSocialMediaToMember do
  use Ecto.Migration

  def change do
    alter table(:members) do
      add :twitter_handle, :string
      add :dribbble_username, :string
      add :website, :string
    end
  end
end
