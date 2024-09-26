defmodule TodoApi.Lists.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirLS.LanguageServer.Plugins.Ecto.Query
  alias TodoApi.Lists.Task
  alias Ecto.Query
  alias TodoApi.Repo

  schema "tasks" do
    field :completed, :boolean, default: false
    field :title, :string
    field :user_id, :id
    field :list_id, :id
    field :order_number, :float, default: 0.0
    field :move_count, :integer, default: 50
    timestamps()
  end

  @doc false
  def base_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :list_id, :user_id, :completed, :order_number, :move_count])
  end

  def create_task_changeset(task, attrs) do
    latest_task = Task |> Query.last |> Repo.one
    task
    |> base_changeset(attrs)
    |> put_change(:order_number, (latest_task.id + 1) / 1)
    |> validate_required([:title, :completed, :list_id])
  end

  @spec update_changeset(
          {map(), map()}
          | %{
              :__struct__ => atom() | %{:__changeset__ => any(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def update_changeset(task, attrs) do
    task
    |> base_changeset(attrs)
  end
end
