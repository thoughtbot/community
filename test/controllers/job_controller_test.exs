defmodule Community.JobControllerTest do
  use Community.ConnCase
  alias Community.Job

  describe "POST /jobs" do
    context "with valid params" do
      it "creates the job", %{conn: conn} do
        conn = post conn, "/jobs", job: fields_for(:job, %{title: "designer"})

        assert get_flash(conn, :info) == "Job created"
        assert redirected_to(conn, 302) =~ "/jobs"
        assert Repo.one(Job).title == "designer"
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
      }) |> approve |> create
      not_approved = create(:job, %{title: "SPAM"})

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
        }) |> approve |> create

        conn = get conn, "/jobs/#{approved.id}"

        assert html_response(conn, 200) =~ approved.title
        assert html_response(conn, 200) =~ approved.company
        assert html_response(conn, 200) =~ approved.city
      end
    end

    context "when the job is not approved" do
      it "redirects to the root", %{conn: conn} do
        job = create(:job, approved: false)

        conn = get conn, "/jobs/#{job.id}"

        assert redirected_to(conn, 302) == "/"
      end
    end

    context "when the job is not approved but the correct token is provided" do
      it "renders the show" do
        job = create(:job, approved: false)

        conn = get conn, "/jobs/#{job.id}?token=#{job.token}"

        assert html_response(conn, 200) =~ "This job is awaiting approval"
      end
    end
  end
end
