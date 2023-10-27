defmodule TimeManager.UserTeams.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_teams" do

    field :fk_user, :binary_id
    field :fk_team, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_team, attrs) do
    user_team
    |> cast(attrs, [])
    |> validate_required([])
  end
end
