defmodule Community.OrganizationView do
  use Phoenix.HTML
  alias Community.Queries.Organization

  def twitter_link do
    organization = Organization.find_organization
    link(
      "@#{organization.twitter}",
      to: "https://twitter.com/#{organization.twitter}"
    )
  end
end
