defmodule Community.MemberTest do
  use Community.ModelCase

  alias Community.Member

  test "changeset with valid attributes" do
    changeset = Member.changeset(%Member{}, fields_for(:member))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Member.changeset(%Member{}, %{})
    refute changeset.valid?
  end

  test "approved only includes entries where approved is true" do
    approved_entry = create(:member, %{approved: true})
    _non_approved_entry = create(:member, %{approved: false})

    approved = Member |> Member.approved |> Repo.all
    assert approved == [approved_entry]
  end

  test "email must be unique" do
    existing_member = create(:member, email: "test@example.com")
    changeset = Member.changeset(%Member{}, fields_for(:member, email: existing_member.email))
    {:error, changeset} = Repo.insert(changeset)
    assert changeset.errors[:email] == {"has already been taken", []}
  end

  test "changeset requires twitter, dribbble or website" do
    changeset = Member.changeset(%Member{}, fields_for(:member, website: ""))
    refute changeset.valid?

    assert changeset.errors[:social_media] == {"you must provide at least one social media contact", []}

    changeset = Member.changeset(%Member{}, fields_for(:member, website: "", dribbble_username: "ralph"))
    assert changeset.valid?
  end
end
