defmodule Community.AssignOrganizationTest do
  use Community.ConnCase, async: true
  alias Community.AssignOrganization
  alias Community.Organization

  describe "call" do
    test "assigns the organization" do
      conn = AssignOrganization.call(%Plug.Conn{}, [])

      assert %Organization{} = conn.assigns[:organization]
    end
  end
end
