defmodule Community.Repo.Migrations.ChangeMemberCompanyNameToTitle do
  use Ecto.Migration

  def change do
    rename table(:members), :company_name, to: :title
  end
end
