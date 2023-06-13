defmodule TodoApi.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :description, :string
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
