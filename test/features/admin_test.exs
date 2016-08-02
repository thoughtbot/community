defmodule Community.Feature.AdminTest do
  use Community.FeatureCase

  test "it allows admins to see the jobs" do
    job = insert(:job)

    navigate_to "/admin/jobs"

    assert flash_text =~ "You must log in to see this page"

    navigate_to "/session/new"

    fill_in :session, :password, with: "password"
    submit

    assert visible_page_text =~ job.title
  end
end
