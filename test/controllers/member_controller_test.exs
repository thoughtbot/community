defmodule Community.MemberControllerTest do
  use Community.ConnCase
  alias Community.Member

  test "POST /members with invalid params", %{conn: conn} do
    conn = post conn, "/members", member: %{}

    assert get_flash(conn, :error) == "Your profile couldn't be saved"
    assert Repo.one(Member) == nil
  end

  test "GET /members shows approved members", %{conn: conn} do
    approved = build(:member, %{
      name: "Bob the Builder",
      title: "Freelancer",
      twitter_handle: "bob",
      dribbble_username: "bob-builder",
      website: "http://bob.example.com",
    }) |> approve |> create
    not_approved = create(:member, %{name: "SAM THE JERK"})

    conn = get conn, "/members"
    refute html_response(conn, 200) =~ not_approved.name

    assert html_response(conn, 200) =~ approved.name
    assert html_response(conn, 200) =~ approved.title
    assert html_response(conn, 200) =~ "https://secure.gravatar.com"
    assert html_response(conn, 200) =~ approved.twitter_handle
    assert html_response(conn, 200) =~ approved.dribbble_username
    assert html_response(conn, 200) =~ approved.website
  end
end
