defmodule Community.Feature.JobTest do
  use Community.FeatureCase

  test "publishing a job" do
    job = create(:job, approved: false, preview: true)
    navigate_to job_path(@endpoint, :show, job, token: job.token)

    click_role "publish-job"

    assert flash_text =~ "Job published"
    assert text_for_role("approval") =~ "Your post is hidden"
    refute text_for_role("preview") == "Make some changes"
  end

  test "editing a job" do
    job = create(:job)

    navigate_to job_path(@endpoint, :edit, job, token: job.token)
    fill_in "job", "title", with: "New Title"
    fill_in "job", "company", with: "New Company"
    fill_in "job", "company_url", with: "http://example.com"
    submit

    assert flash_text =~ "Job updated"
    assert visible_page_text =~ "New Title"
  end

  test "deleting a job" do
    job = create(:job, preview: false)
    navigate_to job_path(@endpoint, :show, job, token: job.token)

    ignore_confirm_dialog
    click_on "Delete Post"

    assert flash_text =~ "Job deleted"
  end
end
