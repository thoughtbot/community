defmodule Community.Acceptance.MemberTest do
  use Community.AcceptanceCase
  alias Community.Member

  test "register a new member" do
    navigate_to "/"
    click_on "Member Directory"
    click_on "Add yourself to the directory"
    fill_in "member", "name", with: "Scott Summers"
    fill_in "member", "email", with: "cyclops@example.com"
    fill_in "member", "title", with: "Designer at X-men, Inc"
    fill_in "member", "twitter_handle", with: "cyclops"
    fill_in "member", "dribbble_username", with: "cyclopsdesign"
    fill_in "member", "website", with: "http://www.yahoo.com"
    click_role "member-save"
    assert String.contains?(visible_page_text, "Thank you for signing up!")

    last_member = Repo.one(Member)
    assert last_member.name == "Scott Summers"
    assert last_member.email == "cyclops@example.com"
    assert last_member.title == "Designer at X-men, Inc"
    assert last_member.twitter_handle == "cyclops"
    assert last_member.dribbble_username == "cyclopsdesign"
    assert last_member.approved == false
  end
end
