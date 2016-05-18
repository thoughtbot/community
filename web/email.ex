defmodule Community.Email do
  use Bamboo.Phoenix, view: Community.EmailView
  import Bamboo.Email

  def admin_job_posted(job) do
    new_email
    |> to(System.get_env("ADMIN_EMAILS"))
    |> from("noreply@raleighdesign.io")
    |> subject("A new job has been posted")
    |> render("admin_job_posted.text", job: job)
  end

  def job_posted(job) do
    new_email
    |> to(job.contact)
    |> from("noreply@raleighdesign.io")
    |> subject("Thank you for posting")
    |> render("job_posted.text", job: job)
  end

  def contact_form(data) do
    new_email
    |> to(data[:to])
    |> from("noreply@raleighdesign.io")
    |> put_header("Reply-To", data.from)
    |> subject("Raleigh Design Contact Form - #{data.subject}")
    |> render("contact_form.text", body: data.body, from: data.from)
  end
end
