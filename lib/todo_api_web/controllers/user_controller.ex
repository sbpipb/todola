defmodule TodoApiWeb.UserController do

  use TodoApiWeb, :controller
  alias TodoApi.Accounts

  def register(conn, %{"user" => params}) do

    case Accounts.User.register_user(params) do
      {:ok, user } ->
        conn |> json(%{message: "User created", username: user.username, user: user.id})

      {:error, _changeset } ->
        conn
        |> put_status(:bad_request)
        |> json(%{message: "Failed to register"})
    end
  end
end
