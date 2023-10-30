defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Teams
  alias TimeManager.Teams.Team
  alias TimeManager.Repo
  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    # teams = Teams.list_teams()
    teams = Teams.get_teams_with_users()
    render(conn, :index, teams: teams)
  end

  # def index(conn, _params) do
  #   teams = Repo.all(TimeManager.Teams.Team) |> Repo.preload(:users)
  #   render(conn, :index, teams: teams)
  # end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Teams.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/teams/#{team}")
      |> render(:show, team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    render(conn, :show, team: team,)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{} = team} <- Teams.update_team(team, team_params) do
      render(conn, :show, team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{}} <- Teams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
