defmodule Community.Router do
  use Community.Web, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Community do
    pipe_through :browser

    get "/", HomePageController, :show, as: :root
    get "/pages/:id", PageController, :show
    resources "/jobs", JobController
    resources "/members", MemberController, only: [:index, :new, :create]

    resources "/session", SessionController, only: [:new, :create]
  end

  scope "/admin", ExAdmin do
    pipe_through [:browser, Community.RequireAdmin]
    admin_routes
  end
end
