defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:id, :password, :role, :firstname, :lastname, :email]}
  schema "users" do
    field :password, :string
    field :role, :string
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    has_many :user_teams, TimeManager.UserTeams.UserTeam
    many_to_many :teams, TimeManager.Teams.Team, join_through: TimeManager.UserTeams.UserTeam

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :password, :role])
    |> validate_required([:firstname, :lastname, :email, :password, :role])
  end

  defimpl Canada.Can, for: MyApp.User do
    def can?(%MyApp.User{id: user_id}, action, %Post{user_id: user_id})
      when action in [:update, :read, :destroy, :touch], do: true

    def can?(%MyApp.User{admin: admin}, action, _)
      when action in [:update, :read, :destroy, :touch], do: admin

    def can?(%MyApp.User{}, :create, Post), do: true
  end
end
