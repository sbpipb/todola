defmodule TodoApiWeb.SessionController do
  use TodoApiWeb, :controller

  # alias TodoApi.Repo

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"user" => %{ "username"=>username, "password" => password}}) do

    with {:ok, user} <- TodoApi.Accounts.authenticate({username, password}),
         {:ok, token} <- TodoApiWeb.Authentication.tokenize(user) do
      conn
      |> TodoApiWeb.Authentication.sign_in(user, session: false)
      |> json(%{token: token})
    end
  end

  def destroy(conn, _params) do
    conn
    |> TodoApiWeb.Authentication.sign_out(session: false)
    |> send_resp(204, "")
  end
end
