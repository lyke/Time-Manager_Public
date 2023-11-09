defmodule TimeManagerWeb.TaskController do
  use TimeManagerWeb, :controller

  alias TimeManager.Plannings
  alias TimeManager.Plannings.Task
  import TimeManagerWeb.Authorization

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    if is_identified(conn) do
      tasks = Plannings.list_tasks()
      render(conn, :index, tasks: tasks)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def create(conn, %{"task" => task_params}) do
    if is_identified(conn) do
      with {:ok, %Task{} = task} <- Plannings.create_task(task_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/tasks/#{task}")
        |> render(:show, task: task)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def show(conn, %{"id" => id}) do
    task = Plannings.get_task!(id)
    if verify_role(conn, "super_manager") || verify_role(conn, "manager") || Enum.member?(task.users, extract_user(conn)) do
      render(conn, :show, task: task)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Plannings.get_task!(id)
    if verify_role(conn, "super_manager") || verify_role(conn, "manager") || Enum.member?(task.users, extract_user(conn)) do
      with {:ok, %Task{} = task} <- Plannings.update_task(task, task_params) do
        render(conn, :show, task: task)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Plannings.get_task!(id)
    if verify_role(conn, "super_manager") || verify_role(conn, "manager") || Enum.member?(task.users, extract_user(conn)) do
      with {:ok, %Task{}} <- Plannings.delete_task(task) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end
end
