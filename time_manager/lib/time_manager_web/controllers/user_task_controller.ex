defmodule TimeManagerWeb.UserTaskController do
  use TimeManagerWeb, :controller

  alias TimeManager.UserTasks
  alias TimeManager.UserTasks.UserTask

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    user_tasks = UserTasks.list_user_tasks()
    render(conn, :index, user_tasks: user_tasks)
  end

  def create(conn, %{"user_task" => user_task_params}) do
  # def create(conn, %{"user_task" => %{"user_id" => user_id, "task_id" => task_id}}) do
    # user_task_params = %{"user_id" => user_id, "task_id" => task_id}
    # IO.inspect(user_task_params)
    with {:ok, %UserTask{} = user_task} <- UserTasks.create_user_task(user_task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/user_tasks/#{user_task}")
      # |> put_resp_header("location", ~p"/api/users/:user_id/user_tasks/#{user_task}")
      |> render(:show, user_task: user_task)
    end
  end

  def show(conn, %{"id" => id}) do
    user_task = UserTasks.get_user_task!(id)
    render(conn, :show, user_task: user_task)
  end

  def update(conn, %{"id" => id, "user_task" => user_task_params}) do
    user_task = UserTasks.get_user_task!(id)

    with {:ok, %UserTask{} = user_task} <- UserTasks.update_user_task(user_task, user_task_params) do
      render(conn, :show, user_task: user_task)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_task = UserTasks.get_user_task!(id)

    with {:ok, %UserTask{}} <- UserTasks.delete_user_task(user_task) do
      send_resp(conn, :no_content, "")
    end
  end
end
