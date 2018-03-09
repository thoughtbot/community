defmodule Community.Feature.MemberTest do
  use Community.FeatureCase
  alias Community.Member
  use Bamboo.Test, shared: true

  test "register a new member", %{organization: organization} do
    navigate_to "/"
    click_on "Member Directory"
    click_on "Add yourself to the directory"
    fill_in "member", "name", with: "Scott Summers"
    fill_in "member", "email", with: "cyclops@example.com"
    fill_in "member", "title", with: "Designer at X-men, Inc"
    fill_in "member", "twitter_handle", with: "cyclops"
    fill_in "member", "dribbble_username", with: "cyclopsdesign"
    fill_in "member", "website", with: "http://www.yahoo.com"
    check_label("member_available_for_hire")

    click_role "member-save"
    assert String.contains?(visible_page_text(), "Thanks for signing up!")

    last_member = Repo.one(Member)
    assert last_member.name == "Scott Summers"
    assert last_member.email == "cyclops@example.com"
    assert last_member.title == "Designer at X-men, Inc"
    assert last_member.twitter_handle == "cyclops"
    assert last_member.dribbble_username == "cyclopsdesign"
    assert last_member.available_for_hire == true
    assert last_member.approved == false

    assert_delivered_email Community.Email.member_added(last_member, organization)
    assert_delivered_email Community.Email.admin_member_added(last_member, organization)
  end

  test "contacts a member that is available for hire", %{organization: organization} do
    member = insert(:member, available_for_hire: true, approved: true)
    navigate_to "/members"

    click_on "Available for Hire"

    assert visible_page_text() =~ member.name

    email_data = %{
      subject: "Hi there",
      body: "Let's work together",
      from: "bob@example.com",
      to: member.email,
    }
    fill_in "contact_form", "subject", with: email_data.subject
    fill_in "contact_form", "body", with: email_data.body
    fill_in "contact_form", "email", with: email_data.from
    submit()

    assert flash_text() =~ "Your email has been sent"
    assert_delivered_email Community.Email.contact_form(email_data, organization)
  end

  test "editing a member" do
    member = insert(:member, approved: true)

    navigate_to member_path(@endpoint, :edit, member, token: member.token)
    fill_in "member", "name", with: "New Name"
    submit()

    assert flash_text() =~ "Member updated"
    assert visible_page_text() =~ "New Name"
  end

  test "deleting a member" do
    member = insert(:member)
    navigate_to member_path(@endpoint, :edit, member, token: member.token)

    ignore_confirm_dialog()
    click_on "Delete your profile"

    assert flash_text() =~ "Your profile has been deleted"
    refute Repo.get(Member, member.id)
  end

  defp check_label(name) do
    find_element(:css, "[for=#{name}]")
    |> click
  end
end
