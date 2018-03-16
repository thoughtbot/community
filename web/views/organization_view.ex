defmodule Community.OrganizationView do
  use Phoenix.HTML

  def twitter_link(twitter) do
    link(
      "@#{twitter}",
      to: "https://twitter.com/#{twitter}"
    )
  end

  def organization, do: Community.Organization.build()
end
