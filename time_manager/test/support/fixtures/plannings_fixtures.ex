defmodule TimeManager.PlanningsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Plannings` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        end_date: ~N[2023-11-07 09:38:00],
        name: "some name",
        start_date: ~N[2023-11-07 09:38:00],
        status: true,
        type: "some type"
      })
      |> TimeManager.Plannings.create_task()

    task
  end
end
