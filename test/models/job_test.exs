defmodule Community.JobTest do
  use Community.ModelCase

  alias Community.Job

  @valid_attrs %{
    approved: true,
    city: "some content",
    company: "some content",
    company_url: "http://www.example.com",
    description: "some content",
    instructions: "some content",
    preview: true,
    title: "title",
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Job.changeset(%Job{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Job.changeset(%Job{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "validates the url" do
    attributes = Map.merge(@valid_attrs, %{company_url: "something.com"})
    changeset = Job.changeset(%Job{}, attributes)
    refute changeset.valid?
    assert changeset.errors[:company_url] == "must start with http(s)"

    http_attributes = Map.merge(@valid_attrs, %{company_url: "http://"})
    assert  Job.changeset(%Job{}, http_attributes).valid?

    https_attributes = Map.merge(@valid_attrs, %{company_url: "https://"})
    assert  Job.changeset(%Job{}, https_attributes).valid?
  end
end
