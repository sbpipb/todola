defmodule TodoApiWeb.UserController do

  use TodoApiWeb, :controller

  def register(conn, params) do
    # %{ "username" => username, "password" => password } = params
    json(conn, %{ success: true })
  end
end
