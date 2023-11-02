# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManager.Repo.insert!(%TimeManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule TimeManager.Seeds do
  # alias Hex.Repo
  # use Ecto.Seeds
  alias TimeManager.Repo
  alias TimeManager.UserTeams.UserTeam
  alias TimeManager.Teams.Team
  alias TimeManager.Accounts.User
  alias TimeManager.Clocks.Clock
  alias TimeManager.WorkingTimes.WorkingTime

  def run do
    p "supression des seeds existantes"
    # Supprime toutes les seeds existantes
    Repo.delete_all(TimeManager.UserTeams.UserTeam)
    Repo.delete_all(TimeManager.Teams.Team)
    Repo.delete_all(TimeManager.Accounts.User)

    Repo.delete_all(TimeManager.Clocks.Clock)
    Repo.delete_all(TimeManager.WorkingTimes.WorkingTime)

    # --------------------------------------------------------------------------
    p "création des users"

    john_user = %TimeManager.Accounts.User{
      firstname: "John",
      lastname: "Doe",
      email: "john.doe@example.com",
      password: "my_password",
      role: "user"
    }    |> TimeManager.Repo.insert()

    alice_user = %TimeManager.Accounts.User{
      firstname: "Alice",
      lastname: "Smith",
      email: "alice.smith@example.com",
      password: "another_password",
      role: "admin"
    } |> Repo.insert()

    bob_user = %TimeManager.Accounts.User{
      firstname: "Bob",
      lastname: "Johnson",
      email: "bob.johnson@example.com",
      password: "secret_password",
      role: "user"
    } |> Repo.insert()

    # --------------------------------------------------------------------------
    p "création des teams"
    team1 = %TimeManager.Teams.Team{
      name: "Team 1"
    } |> Repo.insert()

    team2 = %TimeManager.Teams.Team{
      name: "Team 2"
    } |> Repo.insert()

    team3 = %TimeManager.Teams.Team{
      name: "Team 3"
    } |> Repo.insert()

    # --------------------------------------------------------------------------
    p "création des user_teams"
    user_team_jonh = %TimeManager.UserTeams.UserTeam{
      fk_user: john_user.id,
      fk_team: team1.id
    } |> Repo.insert()

    user_team_alice = %TimeManager.UserTeams.UserTeam{
      fk_user: alice_user.id,
      fk_team: team1.id
    } |> Repo.insert()

    user_team_bob = %TimeManager.UserTeams.UserTeam{
      fk_user: bob_user.id,
      fk_team: team2.id
    } |> Repo.insert()

    # --------------------------------------------------------------------------
    p "création des clocks"

    john_clock_in = %TimeManager.Clocks.Clock{
      time: ~N[2023-11-02 10:00:00],
        status: false,
        fk_user: john_user.id
    } |> Repo.insert()

    john_clock_out = %TimeManager.Clocks.Clock{
      time: ~N[2023-11-02 18:00:00],
        status: false,
        fk_user: john_user.id
    } |> Repo.insert()

    alice_clock_in = %TimeManager.Clocks.Clock{
      time: ~N[2023-11-02 10:00:00],
        status: false,
        fk_user: alice_user.id
    } |> Repo.insert()

    alice_clock_out = %TimeManager.Clocks.Clock{
      time: ~N[2023-11-02 18:00:00],
        status: false,
        fk_user: alice_user.id
    } |> Repo.insert()

    bob_clock_in = %TimeManager.Clocks.Clock{
      time: ~N[2023-11-02 10:00:00],
        status: false,
        fk_user: bob_user.id
    } |> Repo.insert()

    bob_clock_out = %TimeManager.Clocks.Clock{
      time: ~N[2023-11-02 18:00:00],
        status: false,
        fk_user: bob_user.id
    } |> Repo.insert()
    # --------------------------------------------------------------------------
    p "création des working_times"

    working_time_john = %TimeManager.WorkingTimes.WorkingTime{
      start: john_clock_in.time,
        end: john_clock_out.time,
        fk_user: john_user.id
    } |> Repo.insert()

    working_time_alice = %TimeManager.WorkingTimes.WorkingTime{
      start: alice_clock_in.time,
        end: alice_clock_out.time,
        fk_user: alice_user.id
    } |> Repo.insert()

    working_time_bob = %TimeManager.WorkingTimes.WorkingTime{
      start: bob_clock_in.time,
        end: bob_clock_out.time,
        fk_user: bob_user.id
    } |> Repo.insert()

  end
end
