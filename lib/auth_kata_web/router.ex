defmodule AuthKataWeb.Router do
  use AuthKataWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AuthKataWeb.Auth, repo: AuthKata.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuthKataWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
