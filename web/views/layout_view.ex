defmodule Community.LayoutView do
  use Community.Web, :view
  import Community.Queries.Organization, only: [find_organization: 0]

  def page_action_link(%{page_action: page_action}) do
    link(page_action.text, to: page_action.url, class: "button")
  end

  def page_action_link(_), do: nil
end
