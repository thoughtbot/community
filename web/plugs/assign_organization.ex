defmodule Community.AssignOrganization do
  import Plug.Conn
  alias Community.Organization

  def init(default), do: default

  def call(conn, _default) do
    conn
    |> assign(:organization, Organization.build())
  end
end
