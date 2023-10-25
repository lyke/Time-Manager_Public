defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :firstname, :string
      add :lastname, :string
      add :email, :string
      add :password, :string
      add :role, :string
      add :team, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
