defmodule Community.MemberContactControllerTest do
  use Community.ConnCase

  test "POST with invalid params", %{conn: conn} do
    member = insert(:member, available_for_hire: true, approved: true)
    conn = post conn, "/members/#{member.id}/contact", contact_form: %{}

    assert get_flash(conn, :error) == "Your email couldn't be sent"
  end
end
