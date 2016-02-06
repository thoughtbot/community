defmodule Community.JobControllerTest do
  use Community.ConnCase
  alias Community.Repo
  alias Community.Job

  test "POST /jobs with valid params", %{conn: conn} do
    job_params = %{
      title: "designer",
      company: "thoughtbot",
      city: "Raleigh",
      company_url: "http://example.com",
      description: "DO IT",
      instructions: "apply now",
    }

    conn = post conn, "/jobs", job: job_params

    assert get_flash(conn, :info) == "Job created"
    assert redirected_to(conn, 302) =~ "/"
    last_job = Repo.one(Job)
    assert last_job.title == "designer"
  end

  test "POST /jobs with invalid params", %{conn: conn} do
    job_params = %{}

    conn = post conn, "/jobs", job: job_params

    assert get_flash(conn, :error) == "Job not created"
    last_job = Repo.one(Job)
    assert last_job == nil
  end
end
