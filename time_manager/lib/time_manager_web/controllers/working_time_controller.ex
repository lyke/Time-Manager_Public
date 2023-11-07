defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.WorkingTimes
  alias TimeManager.WorkingTimes.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    if is_identified(conn) do
      working_times = WorkingTimes.list_working_times()
      render(conn, :index, working_times: working_times)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def create(conn, %{"working_time" => working_time_params}) do
    if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") do
      with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.create_working_time(working_time_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/working_times/#{working_time}")
        |> render(:show, working_time: working_time)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def show(conn, %{"id" => id}) do
    if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") do
      working_time = WorkingTimes.get_working_time!(id)
      render(conn, :show, working_time: working_time)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") do
      working_time = WorkingTimes.get_working_time!(id)

      with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.update_working_time(working_time, working_time_params) do
        render(conn, :show, working_time: working_time)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def delete(conn, %{"id" => id}) do
      if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") do
      working_time = WorkingTimes.get_working_time!(id)

      with {:ok, %WorkingTime{}} <- WorkingTimes.delete_working_time(working_time) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end
end
