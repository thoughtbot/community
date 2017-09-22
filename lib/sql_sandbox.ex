defmodule Community.Phoenix.Ecto.SQL.Sandbox do
  import Plug.Conn

  @config_path "/phoenix/ecto/sql/sandbox/"

  def path_for(repo, pid) do
    "#{@config_path}#{:erlang.pid_to_list(pid)}|#{Atom.to_string(repo)}"
  end

  @cookie_name "phoenix.ecto.sql.sandbox"

  def init(opts), do: opts

  def call(%{request_path: @config_path <> configuration} = conn, _opts) do
    conn |> put_resp_cookie(@cookie_name, configuration) |> send_resp(200, "OK") |> halt
  end

  def call(conn, sandbox) do
    conn |> fetch_cookies |> allow_sandbox_access(sandbox)
  end

  defp allow_sandbox_access(%{req_cookies: %{@cookie_name => configuration}} = conn, _sandbox) do
    [pid_string,repo_string] = configuration |> URI.decode |> String.split("|")

    owner = to_pid(pid_string)
    repo  = String.to_atom(repo_string)

    Ecto.Adapters.SQL.Sandbox.allow(repo, owner, self())

    conn
  end
  defp allow_sandbox_access(conn, _sandbox), do: conn

  defp to_pid(string) do
    string |> String.to_charlist |> :erlang.list_to_pid
  end
end
