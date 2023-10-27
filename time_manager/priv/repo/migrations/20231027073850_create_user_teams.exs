defmodule TimeManager.Repo.Migrations.CreateUserTeams do
  use Ecto.Migration

  def change do
    create table(:user_teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :team_id, references(:teams, on_delete: :nothing, type: :binary_id)


      timestamps(type: :utc_datetime)
    end
    create index(:user_teams, [:team_id])
    create index(:user_teams, [:user_id])
    # create unique_index(:user_teams, [:team_id, :user_id])
  end
end
