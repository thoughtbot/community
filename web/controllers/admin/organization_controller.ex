defmodule Community.Admin.OrganizationController do
  use Community.Web, :controller
  alias Community.Organization

  def edit(conn, _params) do
    changeset = Organization.changeset(find_organization())

    conn
    |> render_edit(changeset)
  end

  def update(conn, %{"organization" => params}) do
    find_organization()
    |> Organization.changeset(params)
    |> Repo.update
    |> case do
      {:ok, _organization} ->
        conn
        |> put_flash(:info, gettext("Organization updated"))
        |> redirect(to: admin_organization_path(conn, :edit))

      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Error updating organization"))
        |> render_edit(changeset)
    end
  end

  defp render_edit(conn, changeset) do
    conn
    |> assign(:oranization, changeset.data)
    |> assign(:changeset, changeset)
    |> render(:edit)
  end
end
