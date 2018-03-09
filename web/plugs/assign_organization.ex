defmodule Community.AssignOrganization do
  import Plug.Conn
  import Community.Queries.Organization, only: [find_organization: 0]

  def init(default), do: default

  def call(conn, _default) do
    conn
    |> assign(:organization, find_organization())
  end
end
