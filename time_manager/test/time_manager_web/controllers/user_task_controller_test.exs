defmodule TimeManagerWeb.UserTaskControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.UserTasksFixtures

  alias TimeManager.UserTasks.UserTask

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_tasks", %{conn: conn} do
      conn = get(conn, ~p"/api/user_tasks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_task" do
    test "renders user_task when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/user_tasks", user_task: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/user_tasks/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/user_tasks", user_task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_task" do
    setup [:create_user_task]

    test "renders user_task when data is valid", %{conn: conn, user_task: %UserTask{id: id} = user_task} do
      conn = put(conn, ~p"/api/user_tasks/#{user_task}", user_task: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/user_tasks/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_task: user_task} do
      conn = put(conn, ~p"/api/user_tasks/#{user_task}", user_task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_task" do
    setup [:create_user_task]

    test "deletes chosen user_task", %{conn: conn, user_task: user_task} do
      conn = delete(conn, ~p"/api/user_tasks/#{user_task}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/user_tasks/#{user_task}")
      end
    end
  end

  defp create_user_task(_) do
    user_task = user_task_fixture()
    %{user_task: user_task}
  end
end
