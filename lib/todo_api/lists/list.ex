defmodule TodoApi.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :description, :string
    field :title, :string
    field :user_id, :id

    timestamps()

    has_many :tasks, TodoApi.Lists.Task# this was added
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
