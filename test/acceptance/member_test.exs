defmodule Community.Acceptance.MemberTest do
  use Community.AcceptanceCase
  alias Community.Member

  test "register a new member" do
    navigate_to "/"
    click_on "MEMBER DIRECTORY"
    click_on "Add yourself to the directory"
    fill_in "member", "name", with: "Scott Summers"
    fill_in "member", "email", with: "cyclops@example.com"
    fill_in "member", "company_name", with: "X-men"
    click_role "member-save"
    assert String.contains?(visible_page_text, "Thank you for signing up!")

    last_member = Repo.one(Member)
    assert last_member.name == "Scott Summers"
    assert last_member.email == "cyclops@example.com"
    assert last_member.company_name == "X-men"
    assert last_member.approved == false
  end
end
