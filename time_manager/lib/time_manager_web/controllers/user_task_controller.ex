defmodule TimeManagerWeb.UserTaskController do
  use TimeManagerWeb, :controller

  alias TimeManager.UserTasks
  alias TimeManager.UserTasks.UserTask
  import TimeManagerWeb.Authorization

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    if verify_role(conn, "super_manager") do
      user_tasks = UserTasks.list_user_tasks()
      render(conn, :index, user_tasks: user_tasks)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def create(conn, %{"user_task" => user_task_params}) do
    if is_identified(conn) do
      with {:ok, %UserTask{} = user_task} <- UserTasks.create_user_task(user_task_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/user_tasks/#{user_task}")
        |> render(:show, user_task: user_task)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def show(conn, %{"id" => id}) do
    if verify_role(conn, "super_manager") do
      user_task = UserTasks.get_user_task!(id)
      render(conn, :show, user_task: user_task)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def update(conn, %{"id" => id, "user_task" => user_task_params}) do
    if verify_role(conn, "super_manager") do
      user_task = UserTasks.get_user_task!(id)

      with {:ok, %UserTask{} = user_task} <- UserTasks.update_user_task(user_task, user_task_params) do
        render(conn, :show, user_task: user_task)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def delete(conn, %{"id" => id}) do
    user_task = UserTasks.get_user_task!(id)
    if verify_role(conn, "super_manager") || verify_role(conn, "manager") || extract_user_id(conn) == user_task.user_id do

      with {:ok, %UserTask{}} <- UserTasks.delete_user_task(user_task) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end
end
