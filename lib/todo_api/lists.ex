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

  def create_task_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :list_id, :user_id])
    |> validate_required([:title, :list_id, :user_id])
  end
end
