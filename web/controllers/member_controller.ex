defmodule Community.MemberController do
  use Community.Web, :controller
  alias Community.Member
  alias Community.Repo

  def index(conn, _params) do
    conn
    |> assign(:members, approved_members())
    |> render("index.html")
  end

  defp approved_members do
    Member |> Member.approved |> Repo.all
  end

  def new(conn, _params) do
    changeset = Member.changeset(%Member{})
    conn
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"member" => member_params}) do
    changeset = Member.changeset(%Member{}, member_params)
    case Repo.insert(changeset) do
      {:ok, member} ->
        send_emails(member)
        conn
        |> put_flash(:info, "Thanks for signing up! An admin will approve your
        account shortly. We've sent you an email with details.")
        |> redirect(to: member_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Your profile couldn't be saved")
        |> render("new.html", changeset: changeset)
    end
  end

  def send_emails(member) do
    member
    |> Community.Email.member_added
    |> Community.Mailer.deliver_later

    member
    |> Community.Email.admin_member_added
    |> Community.Mailer.deliver_later
  end

  def edit(conn, %{"id" => id, "token" => token}) do
    member = Repo.get_by(Member, id: id, token: token)
    changeset = Member.changeset(member)
    conn
    |> assign(:token, token)
    |> assign(:changeset, changeset)
    |> render(:edit)
  end

  def update(conn, %{"id" => id, "token" => token, "member" => member_params}) do
    member = Repo.get_by(Member, id: id, token: token)
    changeset = Member.changeset(member, member_params)

    case Repo.update(changeset) do
      {:ok, _member} ->
        conn
        |> put_flash(:info, gettext("Member updated"))
        |> redirect(to: member_path(conn, :index))
      {:error, changeset} ->
        conn
        |> assign(:token, token)
        |> assign(:changeset, changeset)
        |> put_flash(:error, "Member not updated")
        |> render(:edit)
    end
  end

  def delete(conn, %{"id" => id, "token" => token}) do
    member = Repo.get_by(Member, id: id, token: token)
    case Repo.delete(member) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Your profile has been deleted")
        |> redirect(to: root_path(conn, :show))
      {:error, _} ->
        conn
        |> put_flash(:error, "Your profile could not be deleted. Please contact an administrator")
        |> redirect(to: root_path(conn, :show))
    end
  end
end
