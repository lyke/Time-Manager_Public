defmodule TimeManager.Repo.Migrations.CreateUserTasks do
  use Ecto.Migration

  def change do
    create table(:user_tasks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :task_id, references(:tasks, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:user_tasks, [:user_id])
    create index(:user_tasks, [:task_id])
  end
end
