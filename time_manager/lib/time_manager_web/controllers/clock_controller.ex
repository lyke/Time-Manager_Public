defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Clocks
  alias TimeManager.Clocks.Clock



  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
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
  end


  def show(conn, %{"id" => id}) do
    clocks = Clocks.list_clocks()
    filtered_clocks = Enum.filter(clocks, fn clock -> clock.fk_user == id end)
    render(conn, :index, clocks: filtered_clocks)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{}} <- Clocks.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
