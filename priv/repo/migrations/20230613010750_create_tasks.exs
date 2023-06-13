defmodule TodoApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :list_id, references(:lists, on_delete: :nothing)

      add :order_id, :integer
      add :move_count, :integer
      timestamps()
    end

    create index(:tasks, [:user_id])
    create index(:tasks, [:list_id])
  end
end
