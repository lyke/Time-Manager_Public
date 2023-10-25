defmodule TimeManager.WorkingTimesTest do
  use TimeManager.DataCase

  alias TimeManager.WorkingTimes

  describe "working_times" do
    alias TimeManager.WorkingTimes.WorkingTime

    import TimeManager.WorkingTimesFixtures

    @invalid_attrs %{start: nil, end: nil}

    test "list_working_times/0 returns all working_times" do
      working_time = working_time_fixture()
      assert WorkingTimes.list_working_times() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert WorkingTimes.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{start: ~N[2023-10-24 13:25:00], end: ~N[2023-10-24 13:25:00]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimes.create_working_time(valid_attrs)
      assert working_time.start == ~N[2023-10-24 13:25:00]
      assert working_time.end == ~N[2023-10-24 13:25:00]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkingTimes.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{start: ~N[2023-10-25 13:25:00], end: ~N[2023-10-25 13:25:00]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimes.update_working_time(working_time, update_attrs)
      assert working_time.start == ~N[2023-10-25 13:25:00]
      assert working_time.end == ~N[2023-10-25 13:25:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = WorkingTimes.update_working_time(working_time, @invalid_attrs)
      assert working_time == WorkingTimes.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = WorkingTimes.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimes.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = WorkingTimes.change_working_time(working_time)
    end
  end
end
