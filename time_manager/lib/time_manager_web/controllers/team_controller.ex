defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Teams
  alias TimeManager.Teams.Team
  import TimeManagerWeb.Authorization
  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    # if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") do
      teams = Teams.get_teams_with_users()
      render(conn, :index, teams: teams)
    # else
    #   conn
    #   |> put_status(:unauthorized)
    #   |> json(%{error: gettext("unauthorized")})
    # end
  end

  def create(conn, %{"team" => team_params}) do
    if verify_role_super_manager(conn, "super_manager") do
      with {:ok, %Team{} = team} <- Teams.create_team(team_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/teams/#{team}")
        |> render(:show_without_users, team: team)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def show(conn, %{"id" => id}) do
    if verify_role_super_manager(conn, "super_manager") || (verify_role_manager(conn, "manager") && is_member_of_team(conn, id)) do
      team = Teams.get_team!(id)
    # IO.inspect(is_member_of_team(conn, team))
      render(conn, :show, team: team)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    if verify_role_super_manager(conn, "super_manager") do
      team = Teams.get_team!(id)
      with {:ok, %Team{} = team} <- Teams.update_team(team, team_params) do
        render(conn, :show, team: team)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def delete(conn, %{"id" => id}) do
    if verify_role_super_manager(conn, "super_manager") do
      team = Teams.get_team!(id)
      with {:ok, %Team{}} <- Teams.delete_team(team) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end
end
