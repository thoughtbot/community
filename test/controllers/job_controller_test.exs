defmodule Community.JobControllerTest do
  use Community.ConnCase

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
    #assert that something was created in the db
  end
end
