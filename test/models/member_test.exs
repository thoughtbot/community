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
end
