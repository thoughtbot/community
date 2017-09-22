defmodule Community.SessionController do
  use Community.Web, :controller

  def new(conn, _params) do
    conn
    |> render(:new)
  end

  def create(conn, %{"session" => %{"password" => password}}) do
    if password == System.get_env("ADMIN_KEY") do
      conn
      |> put_session(:admin_key, password)
      |> put_flash(:info, "Welcome home!")
      |> redirect(to: redirect_path(conn))
    else
      prevent_brute_force_attacks()

      conn
      |> put_flash(:error, "NOPE")
      |> redirect(to: "/")
    end
  end

  defp prevent_brute_force_attacks do
    :timer.sleep(1000)
  end

  defp redirect_path(conn) do
    get_session(conn, :redirect_path) || "/"
  end
end
