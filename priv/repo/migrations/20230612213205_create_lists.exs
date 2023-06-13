defmodule TodoApi.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :title, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing)

      # add :order_id,
      timestamps()
    end

    create unique_index(:lists, [:title])
    create index(:lists, [:user_id])
  end
end
