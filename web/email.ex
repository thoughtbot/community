defmodule Community.Email do
  use Bamboo.Phoenix, view: Community.EmailView
  import Community.OrganizationView
  import Bamboo.Email

  def admin_job_posted(job) do
    new_email()
    |> to(admin_emails())
    |> from(organization().no_reply_email_address)
    |> subject("A new job has been posted")
    |> render("admin_job_posted.text", job: job)
  end

  def job_posted(job) do
    new_email()
    |> to(job.contact)
    |> from(organization().no_reply_email_address)
    |> subject("Thank you for posting")
    |> render("job_posted.text", job: job)
  end

  def admin_member_added(member) do
    new_email()
    |> to(admin_emails())
    |> from(organization().no_reply_email_address)
    |> subject("A new member has signed up!")
    |> render("admin_member_added.text", member: member)
  end

  def member_added(member) do
    new_email()
    |> to(member.email)
    |> from(organization().no_reply_email_address)
    |> subject("Thank you for signing up")
    |> render("member_added.text", member: member)
  end

  def contact_form(data) do
    new_email()
    |> to(data[:to])
    |> from(organization().no_reply_email_address)
    |> put_header("Reply-To", data.from)
    |> subject("Raleigh Design Contact Form - #{data.subject}")
    |> render("contact_form.text", body: data.body, from: data.from)
  end

  defp admin_emails do
    organization().admin_email_address
    |> String.split(",")
  end
end
