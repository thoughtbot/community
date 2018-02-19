defmodule Community.Email do
  use Bamboo.Phoenix, view: Community.EmailView
  import Bamboo.Email
  import Community.Queries.Organization

  def admin_job_posted(job) do
    new_email()
    |> to(admin_emails())
    |> from(find_organization().no_reply_email_address)
    |> subject("A new job has been posted")
    |> render("admin_job_posted.text", job: job)
  end

  def job_posted(job) do
    new_email()
    |> to(job.contact)
    |> from(find_organization().no_reply_email_address)
    |> subject("Thank you for posting")
    |> render("job_posted.text", job: job)
  end

  def admin_member_added(member) do
    new_email()
    |> to(admin_emails())
    |> from(find_organization().no_reply_email_address)
    |> subject("A new member has signed up!")
    |> render("admin_member_added.text", member: member)
  end

  def member_added(member) do
    new_email()
    |> to(member.email)
    |> from(find_organization().no_reply_email_address)
    |> subject("Thank you for signing up")
    |> render("member_added.text", member: member)
  end

  def contact_form(data) do
    new_email()
    |> to(data[:to])
    |> from(find_organization().no_reply_email_address)
    |> put_header("Reply-To", data.from)
    |> subject("Raleigh Design Contact Form - #{data.subject}")
    |> render("contact_form.text", body: data.body, from: data.from)
  end

  defp admin_emails do
    find_organization().admin_email_address
    |> String.split(",")
  end
end
