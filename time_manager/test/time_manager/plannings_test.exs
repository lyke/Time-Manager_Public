defmodule TimeManager.PlanningsTest do
  use TimeManager.DataCase

  alias TimeManager.Plannings

  describe "tasks" do
    alias TimeManager.Plannings.Task

    import TimeManager.PlanningsFixtures

    @invalid_attrs %{name: nil, status: nil, type: nil, description: nil, start_date: nil, end_date: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Plannings.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Plannings.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{name: "some name", status: true, type: "some type", description: "some description", start_date: ~N[2023-11-07 09:38:00], end_date: ~N[2023-11-07 09:38:00]}

      assert {:ok, %Task{} = task} = Plannings.create_task(valid_attrs)
      assert task.name == "some name"
      assert task.status == true
      assert task.type == "some type"
      assert task.description == "some description"
      assert task.start_date == ~N[2023-11-07 09:38:00]
      assert task.end_date == ~N[2023-11-07 09:38:00]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Plannings.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{name: "some updated name", status: false, type: "some updated type", description: "some updated description", start_date: ~N[2023-11-08 09:38:00], end_date: ~N[2023-11-08 09:38:00]}

      assert {:ok, %Task{} = task} = Plannings.update_task(task, update_attrs)
      assert task.name == "some updated name"
      assert task.status == false
      assert task.type == "some updated type"
      assert task.description == "some updated description"
      assert task.start_date == ~N[2023-11-08 09:38:00]
      assert task.end_date == ~N[2023-11-08 09:38:00]
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Plannings.update_task(task, @invalid_attrs)
      assert task == Plannings.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Plannings.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Plannings.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Plannings.change_task(task)
    end
  end
end
