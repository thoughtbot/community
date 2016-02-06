defmodule Community.PageController do
  use Community.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
