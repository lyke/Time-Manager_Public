defmodule TimeManager.Repo.Migrations.CreateWorkingTimes do
  use Ecto.Migration

  def change do
    create table(:working_times, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :fk_user, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:working_times, [:fk_user])
  end
end
