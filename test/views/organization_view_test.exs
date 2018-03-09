defmodule Community.OrganizationViewTest do
  use Community.ConnCase, async: true
  alias Community.OrganizationView

  describe "twitter_link" do
    test "outputs a link to the organization's twitter", %{organization: organization} do
      link = OrganizationView.twitter_link() |> safe_to_string

      assert link == "<a href=\"https://twitter.com/#{organization.twitter}\">@#{organization.twitter}</a>"
    end
  end
end
