defmodule Community.JobControllerTest do
  use Community.ConnCase
  alias Community.Job
  use Bamboo.Test

  describe "POST /jobs" do
    context "with valid params" do
      it "creates the job", %{conn: conn, organization: _organization} do
        conn = post conn, "/jobs", job: params_for(:job, %{title: "designer"})

        assert get_flash(conn, :info) == "Job created"
        job = Repo.one(Job)
        assert redirected_to(conn) =~ job_path(conn, :show, job.id, token: job.token)
        assert job.title == "designer"
        assert job.preview == true

        assert_delivered_email Community.Email.job_posted(job)
        assert_delivered_email Community.Email.admin_job_posted(job)
      end
    end

    context "with invalid params" do
      it "returns an error", %{conn: conn} do
        conn = post conn, "/jobs", job: %{}

        assert get_flash(conn, :error) == "Job not created"
        assert Repo.one(Job) == nil
      end
    end
  end

  describe "GET /jobs" do
    it "shows approved posts", %{conn: conn} do
      approved = build(:job, %{
        city: "Dvegas",
        company: "big company name",
        title: "approved",
      }) |> approve |> insert
      not_approved = insert(:job, %{title: "SPAM"})

      conn = get conn, "/jobs"
      refute html_response(conn, 200) =~ not_approved.title

      assert html_response(conn, 200) =~ approved.title
      assert html_response(conn, 200) =~ approved.company
      assert html_response(conn, 200) =~ approved.city
    end
  end

  describe "GET /jobs/:id" do
    context "when the job is approved" do
      it "shows the job", %{conn: conn} do
        approved = build(:job, %{
          city: "Dvegas",
          company: "big company name",
          title: "approved",
        }) |> approve |> insert

        conn = get conn, "/jobs/#{approved.id}"

        assert html_response(conn, 200) =~ approved.title
        assert html_response(conn, 200) =~ approved.company
        assert html_response(conn, 200) =~ approved.city
      end
    end

    context "when the job is not approved" do
      it "redirects to the root", %{conn: conn} do
        job = insert(:job, approved: false)

        conn = get conn, "/jobs/#{job.id}"

        assert redirected_to(conn, 302) == "/"
      end
    end

    context "when the job is not approved but the correct token is provided" do
      it "renders the show", %{conn: conn} do
        job = insert(:job, approved: false, preview: false)

        conn = get conn, "/jobs/#{job.id}?token=#{job.token}"

        assert html_response(conn, 200) =~ "Your post is hidden"
      end
    end
  end
end
