defmodule Community.MemberContactController do
  use Community.Web, :controller
  alias Community.Member
  alias Community.ContactForm
  alias Community.Repo

  def new(conn, %{"member_id" => id}) do
    member = Repo.get(Member, id)
    changeset = ContactForm.changeset(%ContactForm{member: member}, %{})
    conn
    |> assign(:changeset, changeset)
    |> assign(:member, member)
    |> render(:new)
  end

  def create(conn, %{"member_id" => id, "contact_form" => contact_form_params}) do
    member = Repo.get(Member, id)
    changeset = ContactForm.changeset(%ContactForm{member: member}, contact_form_params)
    if changeset.valid? do
      send_contact_email(changeset, member)

      conn
      |> put_flash(:info, "Your email has been sent")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "Your email couldn't be sent")
      |> assign(:changeset, changeset)
      |> assign(:member, member)
      |> render(:new)
    end
  end

  defp send_contact_email(changeset, member) do
    prepare_email_data(changeset, member)
    |> Community.Email.contact_form
    |> Community.Mailer.deliver_later
  end

  defp prepare_email_data(changeset, member) do
    %{
      body: changeset.changes.body,
      to: member.email,
      from: changeset.changes.email,
      subject: changeset.changes.subject,
    }
  end
end
