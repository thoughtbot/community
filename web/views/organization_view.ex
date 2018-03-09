defmodule Community.OrganizationView do
  use Phoenix.HTML

  def twitter_link do
    link(
      "@#{organization().twitter}",
      to: "https://twitter.com/#{organization().twitter}"
    )
  end

  def organization, do: Community.Organization.build()
end
