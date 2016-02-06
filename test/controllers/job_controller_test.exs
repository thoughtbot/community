defmodule Community.JobControllerTest do
  use Community.ConnCase
  alias Community.Repo
  alias Community.Job

  test "POST /jobs with valid params", %{conn: conn} do
    conn = post conn, "/jobs", job: fields_for(:job, %{title: "designer"})

    assert get_flash(conn, :info) == "Job created"
    assert redirected_to(conn, 302) =~ "/"
    last_job = Repo.one(Job)
    assert last_job.title == "designer"
  end

  test "POST /jobs with invalid params", %{conn: conn} do
    conn = post conn, "/jobs", job: %{}

    assert get_flash(conn, :error) == "Job not created"
    assert Repo.one(Job) == nil
  end
end
