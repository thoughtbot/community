defmodule Community.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :admin_email_address, :string, null: false
      add :meetup_slugs, {:array, :string}, default: []
      add :name, :string, null: false
      add :no_reply_email_address, :string, null: false
      add :short_description, :text, null: false
      add :twitter, :string

      timestamps()
    end
  end
end
