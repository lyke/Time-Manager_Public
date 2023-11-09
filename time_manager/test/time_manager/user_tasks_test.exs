defmodule TimeManager.UserTasksTest do
  use TimeManager.DataCase

  alias TimeManager.UserTasks

  describe "user_tasks" do
    alias TimeManager.UserTasks.UserTask

    import TimeManager.UserTasksFixtures

    @invalid_attrs %{}

    test "list_user_tasks/0 returns all user_tasks" do
      user_task = user_task_fixture()
      assert UserTasks.list_user_tasks() == [user_task]
    end

    test "get_user_task!/1 returns the user_task with given id" do
      user_task = user_task_fixture()
      assert UserTasks.get_user_task!(user_task.id) == user_task
    end

    test "create_user_task/1 with valid data creates a user_task" do
      valid_attrs = %{}

      assert {:ok, %UserTask{} = user_task} = UserTasks.create_user_task(valid_attrs)
    end

    test "create_user_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserTasks.create_user_task(@invalid_attrs)
    end

    test "update_user_task/2 with valid data updates the user_task" do
      user_task = user_task_fixture()
      update_attrs = %{}

      assert {:ok, %UserTask{} = user_task} = UserTasks.update_user_task(user_task, update_attrs)
    end

    test "update_user_task/2 with invalid data returns error changeset" do
      user_task = user_task_fixture()
      assert {:error, %Ecto.Changeset{}} = UserTasks.update_user_task(user_task, @invalid_attrs)
      assert user_task == UserTasks.get_user_task!(user_task.id)
    end

    test "delete_user_task/1 deletes the user_task" do
      user_task = user_task_fixture()
      assert {:ok, %UserTask{}} = UserTasks.delete_user_task(user_task)
      assert_raise Ecto.NoResultsError, fn -> UserTasks.get_user_task!(user_task.id) end
    end

    test "change_user_task/1 returns a user_task changeset" do
      user_task = user_task_fixture()
      assert %Ecto.Changeset{} = UserTasks.change_user_task(user_task)
    end
  end
end
