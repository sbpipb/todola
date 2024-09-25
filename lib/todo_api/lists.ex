defmodule TodoApi.Lists do
  @moduledoc """
  The Lists context.
  """

  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias TodoApi.Repo

  # alias TodoApi.Accounts.User
  alias TodoApi.Lists.{List,Task}
  # alias TodoApi.Lists

  def create_list(attrs \\ %{}) do
    %List{}
    |> create_list_changeset(attrs)
    |> Repo.insert()
  end

  def get_list_tasks(list_id) do 
    Repo.all(from t in Task, select: %{title: t.title, completed: t.completed, id: t.id}, where: t.list_id == ^list_id)
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

  def update_task(attrs) do
    Task
    |> Repo.get(attrs)
  end

  def create_task_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :list_id, :user_id])
    |> validate_required([:title, :list_id, :user_id])
  end

  def delete_task(task_id) do
    case Repo.get(Task, task_id) do 
      nil  -> {:missing, task_id }
      task -> Repo.delete task
    end
  end
end
