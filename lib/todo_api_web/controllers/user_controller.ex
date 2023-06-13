defmodule TodoApiWeb.UserController do

  use TodoApiWeb, :controller
  # import TodoApi.Accounts.User
  alias TodoApi.Accounts

  # action_fallback TodoApiWeb.MyFall


  # def index(conn, _params) do
  #   users = User.list_users()
  #   render(conn, :index, users: users)
  # end


  def register(conn, %{"user" => params}) do

    case Accounts.User.register_user(params) do
      {:ok, user } ->
        conn |> json(%{ message: "User created", username: user.username, user: user.id})

      {:error, _changeset } ->
        # TODO: handle better error messaging by parsing changeset errors

        conn
        |> put_status(:bad_request)
        |> json(%{ message: "Failed to register"})
    end
  end
end
