defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User

  action_fallback TimeManagerWeb.FallbackController

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.get_user_by_email!(email) do
      {:ok, %User{} = user} ->
        case Accounts.login_user(user, password) do
          {:ok, _token} ->
            token = Phoenix.Token.sign(TimeManagerWeb.Endpoint, "user auth", user)
            result = %TimeManagerWeb.UserResult{user_id: user.id, token: token}
            conn
            |> put_status(:ok)
            |> json(result)
          {:error, _} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: gettext("email or password is incorrect")})
        end
      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: gettext("user not found")})
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

#  get the (+ or -) time credit of the user, in minutes.
  def get_time_credit(conn, %{"id" => id}) do
    minutes_per_day = 7 * 60

    working_times = TimeManager.WorkingTimes.list_working_times()
    user_wts = Enum.filter(working_times, fn working_time -> working_time.fk_user == id end)
    credit_time = Enum.reduce(user_wts, 0, fn working_time, acc ->
      daily_minutes_working = NaiveDateTime.diff(working_time.end, working_time.start) /60
      acc + (daily_minutes_working - minutes_per_day)
    end)
    render(conn, :show_time_credit, time_credit: credit_time)
  end
end
