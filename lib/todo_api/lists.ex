defmodule TodoApi.Lists do
  @moduledoc """
  The Lists context.
  """

  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias TodoApi.Repo

  # alias TodoApi.Accounts.User
  alias TodoApi.Lists.{List, Task}

  def create_list(attrs \\ %{}) do
    %List{}
    |> create_list_changeset(attrs)
    |> Repo.insert()
  end

  def get_list_tasks(list_id) do
    Repo.all(from t in Task, where: t.list_id == ^list_id, order_by: t.order_number)
    |> serialize_tasks
  end

  def create_list_changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :description, :user_id])
    |> unique_constraint([:title])
  end

  def create_task(attrs) do
    %Task{}
    |> create_task_changeset(attrs)
    |> Repo.insert()
  end

  def update_task(task_id, task_params) do
    task_id
    |> find_task
    |> Task.changeset(task_params)
    |> Repo.update
  end

  defp find_task(task_id) do
    Task
    |> Repo.get!(task_id)
  end

  def create_task_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :list_id, :user_id])
    |> validate_required([:title, :list_id, :user_id])
  end

  def delete_task(task_id) do
    case Repo.get(Task, task_id) do
      nil  -> {:error, task_id}
      task -> Repo.delete task
    end
  end

  defp serialize_tasks(tasks) do
    tasks
    |> Enum.map(fn t -> %{id: t.id,
                          title: t.title,
                          completed: t.completed,
                          order_number: t.order_number} end)
  end
end
