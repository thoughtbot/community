defmodule Community.JobTest do
  use Community.ModelCase
  alias Community.Job

  test "changeset with valid attributes" do
    changeset = Job.changeset(%Job{}, params_for(:job))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Job.changeset(%Job{}, %{})
    refute changeset.valid?
  end

  test "validates the url" do
    attributes = params_for(:job, %{application_url: "something.com"})
    changeset = Job.changeset(%Job{}, attributes)
    refute changeset.valid?
    assert changeset.errors[:application_url] == {"must start with http(s)", []}

    http_attributes = params_for(:job, %{application_url: "http://"})
    assert  Job.changeset(%Job{}, http_attributes).valid?

    https_attributes = params_for(:job, %{application_url: "https://"})
    assert  Job.changeset(%Job{}, https_attributes).valid?
  end

  test "approved only includes entires where approved is true" do
    approved_entry = insert(:job, %{approved: true})
    _non_approved_entry = insert(:job, %{approved: false})

    approved = Job |> Job.approved |> Repo.all
    assert approved == [approved_entry]
  end
end
