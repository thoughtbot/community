defmodule Community.JobControllerTest do
  use Community.ConnCase
  alias Community.Job

  test "POST /jobs with valid params", %{conn: conn} do
    conn = post conn, "/jobs", job: fields_for(:job, %{title: "designer"})

    assert get_flash(conn, :info) == "Job created"
    assert redirected_to(conn, 302) =~ "/"
    assert Repo.one(Job).title == "designer"
  end

  test "POST /jobs with invalid params", %{conn: conn} do
    conn = post conn, "/jobs", job: %{}

    assert get_flash(conn, :error) == "Job not created"
    assert Repo.one(Job) == nil
  end

  test "GET /jobs shows approved posts", %{conn: conn} do
    approved = build(:job, %{
      city: "Dvegas",
      company: "big company name",
      title: "approved",
    }) |> approve |> create
    not_approved = create(:job, %{title: "SPAM"})

    conn = get conn, "/jobs"
    refute html_response(conn, 200) =~ not_approved.title

    assert html_response(conn, 200) =~ approved.title
    assert html_response(conn, 200) =~ approved.company
    assert html_response(conn, 200) =~ approved.city
  end
end
