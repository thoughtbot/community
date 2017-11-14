defmodule Community.PartnerController do
  use Community.Web, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
