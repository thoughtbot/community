defmodule Community.OrganizationViewTest do
  use Community.ConnCase, async: true
  alias Community.OrganizationView

  describe "twitter_link/1" do
    test "outputs a link to the twitter handle", %{organization: organization} do
      link =
        organization.twitter
        |> OrganizationView.twitter_link
        |> safe_to_string

      assert link == ~s|<a href="https://twitter.com/#{organization.twitter}">@#{organization.twitter}</a>|
    end
  end
end
