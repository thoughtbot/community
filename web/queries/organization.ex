defmodule Community.Queries.Organization do
  alias Community.Organization
  alias Community.Repo

  def find_organization do
    Organization
    |> Repo.one
    |> case do
      nil ->
        %Organization{}
        |> Organization.changeset(Organization.placeholder_organization())
        |> Repo.insert!

      organization ->
        organization
    end
  end
end
