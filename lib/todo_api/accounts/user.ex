defmodule TodoApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias TodoApi.Accounts.User

  schema "users" do
    field :username, :string
    field :password, :string

    timestamps()
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
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)

  end

  @spec register_user(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  def register_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> TodoApi.Repo.insert
  end

  # import Ecto.Query, only: [from: 2]


  # def list_users() do
  #   query = from u in TodoApi.Accounts.User, select: u.username
  #   TodoApi.Repo.all(query)
  # end
end
