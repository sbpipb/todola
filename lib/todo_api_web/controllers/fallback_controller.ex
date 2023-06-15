defmodule TodoApiWeb.FallbackController do
    use Phoenix.Controller
    # import TodoApiWeb.Router.Helpers

    def call(conn, {:error, :not_found}) do
        conn
        |> put_status(:not_found)
        |> json(%{ message: "resource not found"})
    end

    def call(conn, {:error, :unauthenticated}) do
        conn
        |> put_status(401)
        |> json(%{ error: "Unauthenticated"})
        |> halt()
    end

    def call(conn, {:error, :unauthorized}) do
        conn
        |> put_status(:forbidden)
        |> json(%{ message: "Unauthorized"})
    end
end