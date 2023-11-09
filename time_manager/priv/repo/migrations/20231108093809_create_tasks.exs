defmodule TimeManager.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :text
      add :type, :string, null: false
      add :status, :boolean, default: false, null: false
      add :start_date, :naive_datetime, null: false
      add :end_date, :naive_datetime, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
