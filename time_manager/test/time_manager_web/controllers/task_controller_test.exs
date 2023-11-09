defmodule TimeManagerWeb.TaskControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.PlanningsFixtures

  alias TimeManager.Plannings.Task

  @create_attrs %{
    name: "some name",
    status: true,
    type: "some type",
    description: "some description",
    start_date: ~N[2023-11-07 09:38:00],
    end_date: ~N[2023-11-07 09:38:00]
  }
  @update_attrs %{
    name: "some updated name",
    status: false,
    type: "some updated type",
    description: "some updated description",
    start_date: ~N[2023-11-08 09:38:00],
    end_date: ~N[2023-11-08 09:38:00]
  }
  @invalid_attrs %{name: nil, status: nil, type: nil, description: nil, start_date: nil, end_date: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get(conn, ~p"/api/tasks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create task" do
    test "renders task when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/tasks", task: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/tasks/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "end_date" => "2023-11-07T09:38:00",
               "name" => "some name",
               "start_date" => "2023-11-07T09:38:00",
               "status" => true,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/tasks", task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update task" do
    setup [:create_task]

    test "renders task when data is valid", %{conn: conn, task: %Task{id: id} = task} do
      conn = put(conn, ~p"/api/tasks/#{task}", task: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/tasks/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "end_date" => "2023-11-08T09:38:00",
               "name" => "some updated name",
               "start_date" => "2023-11-08T09:38:00",
               "status" => false,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, task: task} do
      conn = put(conn, ~p"/api/tasks/#{task}", task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: conn, task: task} do
      conn = delete(conn, ~p"/api/tasks/#{task}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/tasks/#{task}")
      end
    end
  end

  defp create_task(_) do
    task = task_fixture()
    %{task: task}
  end
end
