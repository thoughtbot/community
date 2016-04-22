defmodule Community.Acceptance.JobTest do
  use Community.AcceptanceCase

  test "editing a job" do
    job = create(:job)

    navigate_to "/jobs/#{job.id}/edit?token=#{job.token}"
    fill_in "job", "title", with: "New Title"
    fill_in "job", "company", with: "New Company"
    fill_in "job", "company_url", with: "http://example.com"
    submit

    assert flash_text =~ "Job updated"
    assert visible_page_text =~ "New Title"
  end
end
