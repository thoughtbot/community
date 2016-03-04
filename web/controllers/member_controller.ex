defmodule Community.MemberController do
  use Community.Web, :controller
  alias Community.Member
  alias Community.Repo

  def index(conn, _params) do
    conn
    |> assign(:members, approved_members)
    |> add_page_action(text: "Add yourself to the directory", url: "/members/new")
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
      {:ok, _member} ->
        conn
        |> put_flash(:info, "Thank you for signing up!")
        |> redirect(to: member_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "You must fill out all the fields")
        |> render("new.html", changeset: changeset)
    end
  end
end
