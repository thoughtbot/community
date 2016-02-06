defmodule Community.JobController do
  use Community.Web, :controller

  def create(conn, params) do
    conn
    |> redirect(to: "/")
  end
end
