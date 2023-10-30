defmodule TimeManager.UserTeams do
  @moduledoc """
  The UserTeams context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo

  alias TimeManager.UserTeams.UserTeam

  @doc """
  Returns the list of user_teams.

  ## Examples

      iex> list_user_teams()
      [%UserTeam{}, ...]

  """
  def list_user_teams do
    Repo.all(UserTeam)
  end

  @doc """
  Gets a single user_team.

  Raises `Ecto.NoResultsError` if the User team does not exist.

  ## Examples

      iex> get_user_team!(123)
      %UserTeam{}

      iex> get_user_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_team!(id), do: Repo.get!(UserTeam, id)

  @doc """
  Creates a user_team.

  ## Examples

      iex> create_user_team(%{field: value})
      {:ok, %UserTeam{}}

      iex> create_user_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_team(attrs \\ %{}) do
    %UserTeam{}
    |> UserTeam.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_team.

  ## Examples

      iex> update_user_team(user_team, %{field: new_value})
      {:ok, %UserTeam{}}

      iex> update_user_team(user_team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_team(%UserTeam{} = user_team, attrs) do
    user_team
    |> UserTeam.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_team.

  ## Examples

      iex> delete_user_team(user_team)
      {:ok, %UserTeam{}}

      iex> delete_user_team(user_team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_team(%UserTeam{} = user_team) do
    Repo.delete(user_team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_team changes.

  ## Examples

      iex> change_user_team(user_team)
      %Ecto.Changeset{data: %UserTeam{}}

  """
  def change_user_team(%UserTeam{} = user_team, attrs \\ %{}) do
    UserTeam.changeset(user_team, attrs)
  end
end
