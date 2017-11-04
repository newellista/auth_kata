defmodule AuthKataWeb.SessionController do
  use AuthKataWeb, :controller

  plug :scrub_params, "session" when action in ~w(create)a

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case AuthKataWeb.Auth.login_by_username_and_password(conn, email, password, repo: AuthKata.Repo) do
      {:ok, conn} ->
        conn
          |> put_flash(:info, "Welcome back!")
          |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
          |> put_flash(:error, "Invalid username/password")
          |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
      |> AuthKataWeb.Auth.logout()
      |> put_flash(:info, "You have been logged out!")
      |> redirect(to: page_path(conn, :index))
  end
end
