defmodule Community.Acceptance.MemberTest do
  use Community.AcceptanceCase
  alias Community.Member

  test "homepage works" do
    navigate_to "/"
    assert String.contains?(visible_page_text, "Welcome to Phoenix")
  end

  test "register a new member" do
    navigate_to "/"
    click_on "Member Directory"
    click_on "Add yourself to the directory"
    fill_in "member_name", "Scott Summers"
    fill_in "member_email", "cyclops@example.com"
    fill_in "member_company_name", "X-men"
    click_role "member-save"
    assert String.contains?(visible_page_text, "Thank you for signing up!")

    last_member = Repo.one(Member)
    assert last_member.name == "Scott Summers"
    assert last_member.email == "cyclops@example.com"
    assert last_member.company_name == "X-men"
    assert last_member.approved == false
  end

  defp click_on(text) do
    find_element(:link_text, text)
    |> click
  end

  defp click_role(name) do
    find_element(:css, "[data-role=#{name}]")
    |> click
  end

  def fill_in(field_id, text) do
    find_element(:id, field_id)
    |> fill_field(text)
  end
end
