defmodule Community.OrganizationTest do
  use Community.ModelCase
  alias Community.Organization

  describe "changeset" do
    test "has validations" do
      valid_params = params_for(:organization)
      invalid_params = params_for(
        :organization,
        name: nil,
        admin_email_address: nil,
        no_reply_email_address: nil,
        short_description: nil
      )

      valid_changeset = %Organization{} |> Organization.changeset(valid_params)
      invalid_changeset = %Organization{} |> Organization.changeset(invalid_params)

      assert valid_changeset.valid?
      refute invalid_changeset.valid?
      assert invalid_changeset.errors[:name]
      assert invalid_changeset.errors[:admin_email_address]
      assert invalid_changeset.errors[:no_reply_email_address]
      assert invalid_changeset.errors[:short_description]
    end

    test "formats twitter" do
      altered_params = params_for(:organization, twitter: "@example")
      params = params_for(:organization, twitter: "example")

      altered_changeset = %Organization{} |> Organization.changeset(altered_params)
      changeset = %Organization{} |> Organization.changeset(params)

      assert altered_changeset.changes.twitter == "example"
      assert changeset.changes.twitter == "example"
    end
  end

  describe "placeholder_organization" do
    test "can create a valid organization" do
      valid_params = Organization.placeholder_organization()

      valid_changeset = %Organization{} |> Organization.changeset(valid_params)

      assert valid_changeset.valid?
    end
  end
end
