defmodule Community.JobPublishController do
  use Community.Web, :controller
  alias Community.Job

  def create(conn, %{"job_id" => id, "token" => token}) do
    job = Repo.get_by(Job, id: id, token: token)
    changeset = Job.publish_changeset(job, %{preview: false})
    Repo.update!(changeset)

    conn
    |> put_flash(:info, gettext("Job published"))
    |> redirect(to: job_path(conn, :show, job, token: token))
  end
end
