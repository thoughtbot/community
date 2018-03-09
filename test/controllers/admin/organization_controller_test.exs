defmodule Community.Admin.OrganizationControllerTest do
  use Community.ConnCase
  alias Community.Organization

  describe "edit" do
    test "renders the edit form", %{conn: conn} do
      conn = get conn, admin_organization_path(conn, :edit, as_admin: true)

      assert html_response(conn, 200) =~ "Edit Organization"
    end
  end

  describe "update" do
    test "updates the organization", %{conn: conn, organization: organization} do
      form = %{
        admin_email_address: "admin_email_updated@example.com",
        logo_url: "https://example.com/logo_url_updated",
        name: "name_updated",
        no_reply_email_address: "no_reply_updated@example.com",
        short_description: "updated description",
        twitter: "example",
        upcoming_meetups_url: "https://example.com/upcoming_meetups_url_updated",
      }

      conn = put(conn, admin_organization_path(
        conn,
        :update,
        organization: form,
        as_admin: true
      ))

      assert redirected_to(conn) == admin_organization_path(conn, :edit)
      assert get_flash(conn, :info) =~ "Organization updated"
      assert Repo.get_by(Organization, Map.put(form, :id, organization.id))
    end

    test "when update fails, renders error message", %{conn: conn, organization: organization} do
      form = %{
        logo_url: "bad_url",
      }

      conn = put(conn, admin_organization_path(
        conn,
        :update,
        organization: form,
        as_admin: true
      ))

      assert get_flash(conn, :error) =~ "Error updating organization"
      assert html_response(conn, 200) =~ "must start with http(s)"
      assert Repo.get!(Organization, organization.id) == organization
    end
  end
end
