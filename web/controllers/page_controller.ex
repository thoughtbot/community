defmodule Community.PageController do
  use Community.Web, :controller

  def show(conn, %{"id" => page_name}) do
    conn
    |> render(page_name |> String.to_atom)
  end
end
