defmodule TodoApiWeb.SessionController do
  use TodoApiWeb, :controller

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, params) do
    # %{ "username" => username, "password" => password } = params

    render(conn, :index, fruits: [])

  end
end
