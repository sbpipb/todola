defmodule TodoApiWeb.TaskController do

  use TodoApiWeb, :controller

  alias TodoApi.Lists

  def index(conn, %{"list_id" => list_id } = params) do
    tasks = Lists.get_list_tasks list_id

    # expected a map, got: [%TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 1, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-24 14:50:09], updated_at: ~N[2024-09-24 14:50:09]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 2, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-24 14:54:50], updated_at: ~N[2024-09-24 14:54:50]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 3, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-24 14:54:56], updated_at: ~N[2024-09-24 14:54:56]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 4, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-24 14:54:57], updated_at: ~N[2024-09-24 14:54:57]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 5, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 05:09:16], updated_at: ~N[2024-09-25 05:09:16]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 6, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 05:09:18], updated_at: ~N[2024-09-25 05:09:18]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 7, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 05:11:09], updated_at: ~N[2024-09-25 05:11:09]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 8, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 06:54:25], updated_at: ~N[2024-09-25 06:54:25]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 9, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 06:55:02], updated_at: ~N[2024-09-25 06:55:02]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 10, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 06:55:25], updated_at: ~N[2024-09-25 06:55:25]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 11, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 07:08:07], updated_at: ~N[2024-09-25 07:08:07]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 12, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 07:15:42], updated_at: ~N[2024-09-25 07:15:42]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 13, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 07:20:03], updated_at: ~N[2024-09-25 07:20:03]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 14, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 07:20:51], updated_at: ~N[2024-09-25 07:20:51]}, %TodoApi.Lists.Task{__meta__: #Ecto.Schema.Metadata<:loaded, "tasks">, id: 15, completed: false, title: "maglaba ngayon umaga", user_id: 1, list_id: 1, inserted_at: ~N[2024-09-25 07:22:14], updated_at: ~N[2024-09-25 07:22:14]}]

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

  def delete(conn, params) do
    json(conn, "luh")
  end
end
