defmodule Community.Email do
  use Bamboo.Phoenix, view: Community.EmailView
  import Bamboo.Email

  def job_posted(job) do
    new_email
    |> to(job.contact)
    |> from("noreply@raleighdesign.io")
    |> subject("Thank you for posting")
    |> render("job_posted.text", job: job)
  end
end
