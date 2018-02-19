defmodule Community.Admin.OrganizationController do
  use Community.Web, :controller
  alias Community.Organization

  def edit(conn, _params) do
    changeset = Organization.changeset(find_organization())

    conn
    |> render_edit(changeset)
  end

  def update(conn, %{"organization" => params}) do
    params =
      params
      |> Map.put("meetup_slugs", format_meetup_slugs(params["meetup_slugs"]))
      |> Map.put("twitter", format_twitter(params["twitter"]))

    find_organization()
    |> Organization.changeset(params)
    |> Repo.update
    |> case do
      {:ok, _organization} ->
        conn
        |> redirect(to: admin_organization_path(conn, :edit))

      {:error, changeset} ->
        conn
        |> render_edit(changeset)
    end
  end

  defp render_edit(conn, changeset) do
    conn
    |> assign(:oranization, changeset.data)
    |> assign(:changeset, changeset)
    |> render(:edit)
  end

  defp format_meetup_slugs(slugs) when is_binary(slugs) do
    slugs
    |> String.replace(" ", "", global: true)
    |> String.split(",")
  end

  defp format_twitter(twitter) when is_binary(twitter) do
    twitter
    |> String.replace("@", "", global: true)
  end
end
