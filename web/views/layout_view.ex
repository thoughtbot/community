defmodule Community.LayoutView do
  use Community.Web, :view

  def page_action_link(%{page_action: page_action}) do
    link(page_action.text, to: page_action.url, class: "button")
  end

  def page_action_link(_) do
  end
end
