defmodule TimeManager.Repo.Migrations.CreateUserTeams do
  use Ecto.Migration

  def change do
    create table(:user_teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :fk_user, references(:users, on_delete: :nothing, type: :binary_id)
      add :fk_team, references(:teams, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:user_teams, [:fk_user])
    create index(:user_teams, [:fk_team])
  end
end
