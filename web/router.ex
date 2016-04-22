defmodule Community.Router do
  use Community.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Community do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/jobs", JobController, only: [:index, :show, :new, :create]
    resources "/members", MemberController, only: [:index, :new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Community do
  #   pipe_through :api
  # end
end
