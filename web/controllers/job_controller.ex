defmodule Community.JobController do
  use Community.Web, :controller
  alias Community.Job

  def create(conn, %{"job" => job_params}) do
    changeset = Job.changeset(%Job{}, job_params)
    {:ok, job} = Repo.insert(changeset)

    conn
    |> put_flash(:info, "Job created")
    |> redirect(to: "/")
  end
end
