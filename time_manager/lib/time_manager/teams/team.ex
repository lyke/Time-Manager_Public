defmodule TimeManager.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset
  # alias TimeManager.UserTeams.UserTeam

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:name]}

  schema "teams" do
    field :name, :string
    has_many :user_teams, TimeManager.UserTeams.UserTeam
    many_to_many :users, TimeManager.Accounts.User, join_through: TimeManager.UserTeams.UserTeam
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
