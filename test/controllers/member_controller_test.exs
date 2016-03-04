defmodule Community.MemberControllerTest do
  use Community.ConnCase
  alias Community.Member

  test "POST /members with invalid params", %{conn: conn} do
    conn = post conn, "/members", member: %{}

    assert get_flash(conn, :error) == "You must fill out all the fields"
    assert Repo.one(Member) == nil
  end

  test "GET /members shows approved members", %{conn: conn} do
    approved = build(:member, %{
      name: "Bob the Builder",
      company_name: "Construction Company",
    }) |> approve |> create
    not_approved = create(:member, %{name: "SAM THE JERK"})

    conn = get conn, "/members"
    refute html_response(conn, 200) =~ not_approved.name

    assert html_response(conn, 200) =~ approved.name
    assert html_response(conn, 200) =~ approved.company_name
  end
end
