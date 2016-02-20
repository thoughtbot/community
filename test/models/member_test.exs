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
end
