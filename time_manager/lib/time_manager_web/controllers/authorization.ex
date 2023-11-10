defmodule TimeManagerWeb.Authorization do
  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.Accounts.User
  use Ecto.Schema


  def verify_user_id(conn, user_id) do
    header = Enum.find(conn.req_headers, fn {k, _} -> k == "authorization" end)
    case header do
      {"authorization", "Bearer " <> token} ->
      case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", token, max_age: 86400) do
        {:ok, token_data} ->
          if token_data.id == user_id do
            true
          else
            false
          end
        {:error, _} -> false
      end
    _ ->
      false
    end
  end

  def verify_role(conn, role) do
    header = Enum.find(conn.req_headers, fn {k, _} -> k == "authorization" end)
    case header do
      {"authorization", "Bearer " <> token} ->
        case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", token, max_age: 86400) do
          {:ok, token_data} ->
            if token_data.role == role do
              true
            else
              false
            end
          {:error, _} -> false
        end
      _ ->
        false
    end
  end

  def is_same_team(conn, user_id) do
    case extract_team_from_token(conn) do
      {:ok, token_team} ->
        case get_team_from_user_id(user_id) do
          {:ok, user_team} ->
            have_common_teams(token_team, user_team)
          {:error, _} -> false
        end
      {:error, _} -> false
    end
  end

  def is_member_of_team(conn, team_id) do
    case extract_team_from_token(conn) do
      {:ok, token_team} ->
        Enum.any?(token_team, fn team -> team.id == team_id end)
      {:error, _} -> false
    end
  end

  def is_identified(conn) do
    case extract_authorization_token(conn) do
      {:ok, token_data} ->
        token_id = token_data.id
        if TimeManager.Repo.get(User, token_id) do
          true
        else
          false
        end
      _ ->
        false
    end
  end

  def extract_user(conn) do
    case extract_authorization_token(conn) do
      {:ok, token_data} ->
        token_id = token_data.id
        user = TimeManager.Repo.get(User, token_id)
        # {:ok, _user}
      _ ->
        :error
    end
  end

  def extract_user_id(conn) do
    case extract_authorization_token(conn) do
      {:ok, token_data} ->
        _token_id = token_data.id
      _ ->
        :error
    end
  end

  defp extract_authorization_token(conn) do
    case Enum.find(conn.req_headers, fn {k, _} -> k == "authorization" end) do
      {"authorization", "Bearer " <> token} ->
        case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", token, max_age: 86400) do
          {:ok, token_data} ->
            {:ok, token_data}
          _ ->
            :error
        end
      _ ->
        :error
    end
  end


  defp extract_team_from_token(conn) do
    header = Enum.find(conn.req_headers, fn {k, _} -> k == "authorization" end)
    case header do
      {"authorization", "Bearer " <> token} ->
        case Phoenix.Token.verify(TimeManagerWeb.Endpoint, "user auth", token, max_age: 86400) do
          {:ok, token_data} ->
            user_with_teams = Repo.preload(token_data, :teams)
            teams = user_with_teams.teams
            {:ok, teams}
          {:error, _} ->
            false
        end
      _ ->
        false
    end
  end

  defp get_team_from_user_id(user_id) do
    if user_with_teams = TimeManager.Repo.get(User, user_id) |> TimeManager.Repo.preload(:teams) do
        teams = user_with_teams.teams
        {:ok, teams}
    else
        {:error, "User not found"}
    end
  end

  defp have_common_teams(manager_teams, user_teams) do
    Enum.any?(manager_teams, fn element ->
    Enum.member?(user_teams, element)
    end)
  end

end
