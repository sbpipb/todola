defmodule TodoApi.Lists do
  @moduledoc """
  The Lists context.
  """

    #
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias TodoApi.Repo
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
    |> Task.create_task_changeset(attrs)
    |> Repo.insert()
  end

  def update_task(task_id, task_params) do
    task = find_task(task_id)
    changeset = Task.base_changeset(task, task_params)

    if changed?(changeset, :order_number) do
      old_order_number = task.order_number
      %{"order_number" => order_number } = task_params
      second_task = Repo.one!(from t in Task, where: t.id == ^order_number)

      task = update_task_order(task, changeset)

      second_task
      |> put_change(:order_number, old_order_number / 1)
      |> Repo.update

      task
    else
      Repo.update changeset
    end
  end

  defp update_task_order(task, changeset) do
    changeset
    |> put_change(:move_count, task.move_count - 1)
    |> validate_number(:move_count, greater_than: 0)
    |> validate_number(:order_number, greater_than_or_equal_to: task.order_number - 1, less_than_or_equal_to: task.order_number + 1)
    |> Repo.update
  end

  @spec delete_task(any()) :: any()
  def delete_task(task_id) do
    case Repo.get(Task, task_id) do
      nil  -> {:error, task_id}
      task -> Repo.delete task
    end
  end

  defp find_task(task_id) do
    Task
    |> Repo.get!(task_id)
  end

  defp serialize_tasks(tasks) do
    tasks
    |> Enum.map(fn t -> %{id: t.id,
                          title: t.title,
                          completed: t.completed,
                          order_number: t.order_number,
                          move_count: t.move_count

                          } end)
  end
end
