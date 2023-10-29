defmodule TimeManagerWeb.UserTeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.UserTeams
  alias TimeManager.UserTeams.UserTeam
  # alias TimeManager.Accounts

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    user_teams = UserTeams.list_user_teams()
    render(conn, :index, user_teams: user_teams)
  end

  def create(conn, %{"user_team" => user_team_params}) do
    with {:ok, %UserTeam{} = user_team} <- UserTeams.create_user_team(user_team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/user_teams/#{user_team}")
      |> render(:show, user_team: user_team)
    end
  end

  def show(conn, %{"id" => id}) do
    user_team = UserTeams.get_user_team!(id)
    # user = Accounts.get_user!(id)
    render(conn, :show, user_team: user_team)
  end

  def update(conn, %{"id" => id, "user_team" => user_team_params}) do
    user_team = UserTeams.get_user_team!(id)

    with {:ok, %UserTeam{} = user_team} <- UserTeams.update_user_team(user_team, user_team_params) do
      render(conn, :show, user_team: user_team)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_team = UserTeams.get_user_team!(id)

    with {:ok, %UserTeam{}} <- UserTeams.delete_user_team(user_team) do
      send_resp(conn, :no_content, "")
    end
  end
end
