defmodule Community.Repo.Migrations.RemoveExtraFieldsFromJobs do
  use Ecto.Migration

  def up do
    alter table(:jobs) do
      remove :description
      remove :instructions
      remove :preview
    end
    rename table(:jobs), :company_url, to: :application_url
  end

  def down do
    alter table(:jobs) do
      add :description, :text, null: false
      add :instructions, :text, null: false
      add :preview, :boolean, null: false, default: true
    end

    rename table(:jobs), :application_url, to: :company_url
  end
end
