defmodule Community.JobView do
  use Community.Web, :view

  def sanitize(text) do
    HtmlSanitizeEx.basic_html(text)
  end
end
