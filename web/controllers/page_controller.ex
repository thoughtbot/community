defmodule Community.PageController do
  use Community.Web, :controller

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      layout: {Community.LayoutView, "landing.html"}
    )
  end
end
