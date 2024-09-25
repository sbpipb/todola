defmodule TodoApiWeb.TaskController do

  use TodoApiWeb, :controller

  alias TodoApi.Lists

  def index(conn, %{"list_id" => list_id } = params) do
    tasks = Lists.get_list_tasks list_id
    # tasks = tasks
    # |> Map.take([:id, :title, :completed])
    json(conn, tasks)
  end

  def create(conn, %{"task" => task_params}) do
    %{"list_id" => list_id} = conn.params

    task_params = task_params
    |> Map.merge(%{"list_id" => list_id})

    case Lists.create_task(task_params) do
        {:ok, task } ->
          json(conn, %{ message: "Task created", title: task.title, id: task.id})

        {:error, changeset } ->
          error_list = []

          conn
          |> put_status(:bad_request)
          |> json(%{ message: "something wrong with your params #{changeset}", errors: error_list})
    end
  end

  def update(conn, %{"task" => task_params}) do
    case Lists.update_task(task_params) do
      {:ok, task } ->
        json(conn, %{ message: "Task created", title: task.title, id: task.id})

      {:error, _changeset } ->
        # TODO: handle better error messaging by parsing changeset errors
        conn
        |> put_status(:bad_request)
        |> json(%{ message: "Failed to register"})
    end
  end

  def delete(conn, %{"id" => task_id } = params) do
    case Lists.delete_task(task_id) do
      {:ok, task } ->
        json(conn, "successfully deleted task")
      {:error, _e } ->
        conn
        |> put_status(:bad_request)
        |> json(%{ message: "failed to delete task #{task_id}"})
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{ message: "cant find task #{task_id}"})
    end
  end
end
