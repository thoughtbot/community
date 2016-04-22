defmodule Community.HomePageControllerTest do
  use Community.ConnCase

  test "GET / shows approved posts", %{conn: conn} do
    approved = build(:job, %{
      city: "Dvegas",
      company: "big company name",
      title: "approved",
    }) |> approve |> create
    not_approved = create(:job, %{title: "SPAM"})

    conn = get conn, "/"

    refute html_response(conn, 200) =~ not_approved.title

    assert html_response(conn, 200) =~ approved.title
    assert html_response(conn, 200) =~ approved.company
    assert html_response(conn, 200) =~ approved.city
  end
end
