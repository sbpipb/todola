defmodule TodoApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :order_number, :float, default: 0.0
    end
  end
end
