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
    pipe_through [:browser, :public_layout]

    get "/", HomePageController, :show, as: :root
    get "/pages/:id", PageController, :show
    get "/partners", PartnerController, :index
    resources "/jobs", JobController do
      resources "/publish", JobPublishController, only: [:create], as: :publish
    end
    resources "/members", MemberController do
      resources "/contact", MemberContactController, only: [:new, :create], as: :contact
    end
    resources "/session", SessionController, only: [:new, :create]
  end

  scope "/admin", Community, as: :admin do
    pipe_through [:browser, :admin_layout, Community.RequireAdmin]

    resources "/jobs", Admin.JobController
    resources "/members", Admin.MemberController
  end

  pipeline :admin_layout do
    plug :put_layout, {Community.LayoutView, "admin.html"}
  end

  pipeline :public_layout do
    plug :put_layout, {Community.LayoutView, "public.html"}
  end
end
