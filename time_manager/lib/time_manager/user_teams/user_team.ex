defmodule TimeManager.UserTeams.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_teams" do
    # @derive {Jason.Encoder, only: [:name, :title]}
    belongs_to :user, TimeManager.Accounts.User
    belongs_to :team, TimeManager.Teams.Team

    timestamps(type: :utc_datetime)
  end

  @primary_key {:user_id, :team_id}

  @doc false
  def changeset(user_team, attrs) do
    user_team
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
  end
end
