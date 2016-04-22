defmodule Community.JobController do
  use Community.Web, :controller
  alias Community.Job

  def index(conn, _params) do
    conn
    |> assign(:jobs, approved_jobs)
    |> add_page_action(text: "Post a Job for Free", url: "/jobs/new")
    |> render("index.html")
  end

  def show(conn, %{"id" => id, "token" => token}) do
    job = Repo.get_by(Job, id: id, token: token)
    conn
    |> show_job(job)
  end

  def show(conn, %{"id" => id}) do
    job = Repo.get_by(Job, id: id, approved: true)
    conn
    |> show_job(job)
  end

  defp show_job(conn, nil) do
    conn
    |> put_flash(:error, gettext("There is no job with that id"))
    |> redirect(to: root_path(conn, :show))
  end

  defp show_job(conn, job) do
    conn
    |> assign(:job, job)
    |> render(:show)
  end

  def new(conn, _params) do
    changeset = Job.changeset(%Job{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"job" => job_params}) do
    changeset = Job.changeset(%Job{}, job_params)
    case Repo.insert(changeset) do
      {:ok, _job} ->
        conn
        |> put_flash(:info, "Job created")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Job not created")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id, "token" => token}) do
    job = Repo.get_by(Job, id: id, token: token)
    changeset = Job.changeset(job)
    conn
    |> assign(:token, token)
    |> assign(:changeset, changeset)
    |> render(:edit)
  end

  def update(conn, %{"id" => id, "token" => token, "job" => job_params}) do
    job = Repo.get_by(Job, id: id, token: token)
    changeset = Job.changeset(job, job_params)

    case Repo.update(changeset) do
      {:ok, job} ->
        conn
        |> put_flash(:info, gettext("Job updated"))
        |> redirect(to: job_path(conn, :show, job, token: token))
      {:error, changeset} ->
        conn
        |> assign(:token, token)
        |> assign(:changeset, changeset)
        |> put_flash(:error, "Job not created")
        |> render(:edit)
    end
  end

  defp approved_jobs do
    Job
    |> Job.approved
    |> Repo.all
  end
end
