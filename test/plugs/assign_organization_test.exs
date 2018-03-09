defmodule Community.AssignOrganizationTest do
  use Community.ConnCase, async: true
  alias Community.AssignOrganization

  describe "call" do
    test "assigns the organization", %{organization: organization} do
      conn = AssignOrganization.call(%Plug.Conn{}, [])

      assert conn.assigns[:organization] == organization
    end
  end
end
