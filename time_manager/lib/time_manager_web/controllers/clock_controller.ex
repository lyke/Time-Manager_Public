defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Clocks
  alias TimeManager.Clocks.Clock
  import TimeManagerWeb.Authorization
  # import Timex
  use Timex



  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    if verify_role_super_manager(conn, "super_manager") do
      clocks = Clocks.list_clocks()
      render(conn, :index, clocks: clocks)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def index_per_user_per_day(conn, %{"user_id" => id}) do
    if verify_role_super_manager(conn, "super_manager") || (verify_role_manager(conn, "manager") && is_same_team(conn, id))|| verify_user_id(conn, id) do
      clocks = Clocks.list_clocks()
      filtered_clocks = Enum.filter(clocks, fn clock -> clock.fk_user == id end)
      {:ok, today_date} = DateTime.now("Europe/Paris")
      naive_datetime = DateTime.to_naive(today_date)
      naive_datetime = NaiveDateTime.to_string(naive_datetime)
      naive_datetime = String.slice(naive_datetime, 0..9)
      filtered_clocks = Enum.filter(filtered_clocks, fn clock -> String.slice(NaiveDateTime.to_string(clock.time), 0..9) == naive_datetime end)
      render(conn, :index, clocks: filtered_clocks)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def create(conn, %{"clock" => clock_params}) do
    if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") || is_identified(conn) do
      user_id = clock_params["fk_user"]
      last_clock = Clocks.get_last_clock(user_id)
      new_status =
      case last_clock do
        nil -> true
        %Clock{status: false} -> true
        _ -> false
      end
      with {:ok, %Clock{} = clock} <- Clocks.create_clock(Map.put(clock_params, "status", new_status)) do
        if new_status == false do
          working_time_params = %{
            "fk_user" => user_id,
            "start" => last_clock.time,
            "end" => clock.time
          }
          TimeManagerWeb.WorkingTimeController.create(conn, %{"working_time" => working_time_params})
        end
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/clocks/#{clock}")
        |> render(:show, clock: clock)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end


  def show(conn, %{"id" => id}) do
    if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") || is_identified(conn) do
      clocks = Clocks.list_clocks()
      filtered_clocks = Enum.filter(clocks, fn clock -> clock.fk_user == id end)
      render(conn, :index, clocks: filtered_clocks)
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") || is_identified(conn) do
      clock = Clocks.get_clock!(id)
      with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
        render(conn, :show, clock: clock)
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end

  def delete(conn, %{"id" => id}) do
    if verify_role_super_manager(conn, "super_manager") || verify_role_manager(conn, "manager") || is_identified(conn) do
      clock = Clocks.get_clock!(id)
      with {:ok, %Clock{}} <- Clocks.delete_clock(clock) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: gettext("unauthorized")})
    end
  end
end
