defmodule Community.Router do
  use Community.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    if Mix.env == :dev do
      forward "/sent_emails", Bamboo.EmailPreviewPlug
    end

  end

  scope "/", Community do
    pipe_through :browser

    get "/", HomePageController, :show, as: :root
    get "/pages/:id", PageController, :show
    resources "/jobs", JobController do
      resources "/publish", JobPublishController, only: [:create], as: :publish
    end
    resources "/members", MemberController, only: [:index, :new, :create]

    resources "/session", SessionController, only: [:new, :create]
  end

  scope "/admin", Community, as: :admin do
    pipe_through [:browser, Community.RequireAdmin]

    resources "/jobs", Admin.JobController
  end
end
