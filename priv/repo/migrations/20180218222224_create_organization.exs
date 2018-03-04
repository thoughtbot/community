defmodule Community.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :admin_email_address, :string, null: false
      add :name, :string, null: false
      add :no_reply_email_address, :string, null: false
      add :short_description, :text, null: false
      add :twitter, :string
      add :upcoming_meetups_url, :string
      add :logo_url, :string, null: false
      add :dribbble_enabled, :boolean, default: true
      add :meetup_enabled, :boolean, default: true

      timestamps()
    end
  end
end
