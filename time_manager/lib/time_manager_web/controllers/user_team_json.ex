defmodule TimeManagerWeb.UserTeamJSON do
  alias TimeManager.UserTeams.UserTeam

  @doc """
  Renders a list of user_teams.
  """
  def index(%{user_teams: user_teams}) do
    %{data: for(user_team <- user_teams, do: data(user_team))}
  end

  @doc """
  Renders a single user_team.
  """
  def show(%{user_team: user_team}) do
    %{data: data(user_team)}
  end

  defp data(%UserTeam{} = user_team) do
    %{
      id: user_team.id,
      fk_user: user_team.fk_user,
      fk_team: user_team.fk_team
    }
  end
end
