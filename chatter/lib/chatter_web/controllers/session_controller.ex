defmodule ChatterWeb.SessionController do
  use ChatterWeb, :controller

  alias Chatter.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_by_email_pass(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome Back")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: "/")

      {:error, :unauthorized} ->
        conn
        |> put_flash(:info, "Bad email/password confirmation")
        |> redirect(to: Routes.session_path(conn, :new))

      {:error, :not_found} ->
        conn
        |> put_flash(:info, "Acoount Not Found")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:success, "Successfully signed_out")
    |> redirect(to: "/")
  end
end
