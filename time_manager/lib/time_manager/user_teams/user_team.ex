defmodule TimeManager.UserTeams.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_teams" do
    @derive {Jason.Encoder, only: [:name, :title]}
    # field :fk_user, :binary_id
    # field :fk_team, :binary_id
    # belongs_to :user, TimeManager.Accounts.User, foreign_key: :fk_user
    # belongs_to :team, TimeManager.Teams.Team, foreign_key: :fk_team
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
