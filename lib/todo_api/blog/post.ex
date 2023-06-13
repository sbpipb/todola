defmodule TodoApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blog_posts" do
    field :title, :string
    field :unique_int, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :unique_int])
    |> validate_required([:title, :unique_int])
    |> unique_constraint(:unique_int)
    |> unique_constraint(:title)
  end
end
