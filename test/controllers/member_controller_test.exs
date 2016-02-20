defmodule Community.MemberControllerTest do
  use Community.ConnCase
  alias Community.Member

  test "POST /members with invalid params", %{conn: conn} do
    conn = post conn, "/members", member: %{}

    assert get_flash(conn, :error) == "You must fill out all the fields"
    assert Repo.last(Member) == nil
  end
end
