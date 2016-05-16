defmodule Community.MemberViewTest do
  use Community.ConnCase, async: true
  import Community.MemberView

  test "gravatar ignores case and whitespace" do
    base = gravatar("admin@example.com")

    assert gravatar("ADMIN@EXAMPLE.COM") == base
    assert gravatar("  admin@example.com  ") == base
  end
end
