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

  test "GET /jobs shows approved posts", %{conn: conn} do
    approved = create(:job, %{approved: true, title: "approved"})
    not_approved = create(:job, %{approved: false, title: "SPAM"})

    conn = get conn, "/jobs"
    assert html_response(conn, 200) =~ approved.title
    refute html_response(conn, 200) =~ not_approved.title
  end
end
