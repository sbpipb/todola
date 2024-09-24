defmodule TodoApiWeb.TaskController do

  use TodoApiWeb, :controller

  alias TodoApi.Lists

  def create(conn, %{"task" => task_params}) do

    case Lists.create_task(task_params) do
        {:ok, task } ->
          json(conn, %{ message: "Task created", title: task.title, id: task.id})

        {:error, _changeset } ->
          # TODO: handle better error messaging by parsing changeset errors
          conn
          |> put_status(:bad_request)
          |> json(%{ message: "Failed to register"})
      end
  end
end
