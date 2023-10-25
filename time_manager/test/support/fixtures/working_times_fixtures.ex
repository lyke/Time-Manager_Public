defmodule TimeManager.WorkingTimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.WorkingTimes` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~N[2023-10-24 13:25:00],
        start: ~N[2023-10-24 13:25:00]
      })
      |> TimeManager.WorkingTimes.create_working_time()

    working_time
  end
end
