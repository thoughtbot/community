defmodule Community.JobTest do
  use Community.ModelCase

  alias Community.Job

  @valid_attrs %{
    approved: true,
    city: "some content",
    company: "some content",
    company_url: "some content",
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
end
