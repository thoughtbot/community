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
        city: nil,
        titles: nil,
        no_reply_email_address: nil,
        short_description: nil
      )

      valid_changeset = Organization.changeset(valid_params)
      invalid_changeset = Organization.changeset(invalid_params)

      assert valid_changeset.valid?
      refute invalid_changeset.valid?
      assert invalid_changeset.errors[:name]
      assert invalid_changeset.errors[:admin_email_address]
      assert invalid_changeset.errors[:no_reply_email_address]
      assert invalid_changeset.errors[:short_description]
      assert invalid_changeset.errors[:city]
      assert invalid_changeset.errors[:titles]
    end

    test "validates twitter" do
      invalid_params = params_for(:organization, twitter: "@example")
      valid_params = params_for(:organization, twitter: "example")

      valid_changeset = Organization.changeset(valid_params)
      invalid_changeset = Organization.changeset(invalid_params)

      assert valid_changeset.valid?
      refute invalid_changeset.valid?
      assert invalid_changeset.errors[:twitter]
    end
  end
end
