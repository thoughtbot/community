defmodule Community.JobTest do
  use Community.ModelCase
  alias Community.Job

  test "changeset with valid attributes" do
    changeset = Job.changeset(%Job{}, fields_for(:job))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Job.changeset(%Job{}, %{})
    refute changeset.valid?
  end

  test "validates the url" do
    attributes = fields_for(:job, %{company_url: "something.com"})
    changeset = Job.changeset(%Job{}, attributes)
    refute changeset.valid?
    assert changeset.errors[:company_url] == "must start with http(s)"

    http_attributes = fields_for(:job, %{company_url: "http://"})
    assert  Job.changeset(%Job{}, http_attributes).valid?

    https_attributes = fields_for(:job, %{company_url: "https://"})
    assert  Job.changeset(%Job{}, https_attributes).valid?
  end

  test "approved only includes entires where approved is true" do
    approved_entry = create(:job, %{approved: true})
    _non_approved_entry = create(:job, %{approved: false})

    approved = Job |> Job.approved |> Repo.all
    assert approved == [approved_entry]
  end
end
