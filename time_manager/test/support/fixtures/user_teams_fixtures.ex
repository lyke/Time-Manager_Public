defmodule TimeManager.UserTeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.UserTeams` context.
  """

  @doc """
  Generate a user_team.
  """
  def user_team_fixture(attrs \\ %{}) do
    {:ok, user_team} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManager.UserTeams.create_user_team()

    user_team
  end
end
