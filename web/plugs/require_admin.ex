defmodule Community.RequireAdmin do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default), do: default

  def call(conn, _default) do
    cond do
      test_backdoor?(conn) ->
        conn
      is_admin?(conn) ->
        conn
      true ->
        conn
        |> put_session(:redirect_path, conn.request_path)
        |> put_flash(:error, "You must log in to see this page")
        |> redirect(to: "/")
        |> halt
    end
  end

  defp is_admin?(conn) do
    case get_session(conn, :admin_key) do
      nil -> false
      admin_key -> admin_key == System.get_env("ADMIN_KEY")
    end
  end

  defp test_backdoor?(conn) do
    Mix.env == :test && conn.query_params["as_admin"]
  end
end
