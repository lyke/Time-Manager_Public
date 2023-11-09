defmodule TimeManager.UserTasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.UserTasks` context.
  """

  @doc """
  Generate a user_task.
  """
  def user_task_fixture(attrs \\ %{}) do
    {:ok, user_task} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManager.UserTasks.create_user_task()

    user_task
  end
end
