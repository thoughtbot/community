defmodule Community.JobController do
  use Community.Web, :controller

  def create(conn, params) do
    conn
    |> put_flash(:info, "Job created")
    |> redirect(to: "/")
  end
end
