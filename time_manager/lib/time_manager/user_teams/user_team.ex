defmodule TimeManager.UserTeams.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_teams" do
    field :fk_user, :binary_id
    field :fk_team, :binary_id
    # belongs_to :user, TimeManager.Accounts.User
    # belongs_to :team, TimeManager.Teams.Team
    # belongs_to :user, TimeManager.Accounts.User, foreign_key: :fk_user
    # belongs_to :team, TimeManager.Teams.Team, foreign_key: :fk_team

    timestamps(type: :utc_datetime)
  end

  @primary_key {:fk_user, :fk_team}

  @doc false
  def changeset(user_team, attrs) do
    user_team
    |> cast(attrs, [:fk_user, :fk_team])
    |> validate_required([:fk_user, :fk_team])
  end
end
