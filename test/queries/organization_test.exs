defmodule Community.Queries.OrganizationTest do
  use Community.ModelCase
  alias Community.Queries
  alias Community.Organization

  describe "find_organization/0" do
    test "when none, creates and returns placeholder organization" do
      refute Organization |> Repo.one()

      organization = Queries.Organization.find_organization()

      assert Repo.get_by(
               Organization,
               Organization.placeholder_organization()
             ).id == organization.id
    end

    test "returns the one organization" do
      organization = insert(:organization)

      fetched_organization = Queries.Organization.find_organization()

      assert fetched_organization.id == organization.id
    end
  end
end
