defmodule TodoApi.Lists.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :completed, :boolean, default: false
    field :title, :string
    field :user_id, :id
    field :list_id, :id
    field :order_number, :float, default: 0.0
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :completed, :order_number])
  end

  def create_changeset(task, attrs) do
    task
    |> changeset(attrs)
    |> validate_required([:title, :completed])
  end

  def update_changeset(task, attrs) do
    task
    |> changeset(attrs)
  end
end
