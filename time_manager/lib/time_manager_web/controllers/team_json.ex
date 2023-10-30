defmodule TimeManagerWeb.TeamJSON do
  alias TimeManager.Teams.Team

  @doc """
  Renders a list of teams.
  """
  def index(%{teams: teams}) do
    %{data: for(team <- teams, do: data(team))}
  end

  @doc """
  Renders a single team.
  """
  def show(%{team: team}) do
    %{data: data(team)}
  end

  def show_without_users(%{team: team}) do
    %{data: data_no_users(team)}
  end

  defp data(%Team{} = team) do
    %{
      id: team.id,
      name: team.name,
      user: team.users
    }
  end

  defp data_no_users(%Team{} = team) do
    %{
      id: team.id,
      name: team.name,
    }
  end
end
