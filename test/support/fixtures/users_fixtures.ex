defmodule Todolist.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        firstname: "some firstname",
        lastname: "some lastname"
      })
      |> Todolist.Users.create_user()

    user
  end
end
