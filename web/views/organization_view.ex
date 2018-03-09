defmodule Community.OrganizationView do
  use Phoenix.HTML

  def twitter_link(organization) do
    link(
      "@#{organization.twitter}",
      to: "https://twitter.com/#{organization.twitter}"
    )
  end
end
