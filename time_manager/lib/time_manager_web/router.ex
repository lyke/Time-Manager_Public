defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit] do
      get "/today_clocks", ClockController, :index_per_user_per_day
    end
    get "/users/time_credit/:id", UserController, :get_time_credit
    post "/login", UserController, :login
    resources "/clocks", ClockController, except: [:new, :edit, :index, :update, :delete]
    get "/clocks", ClockController, :index
    resources "/working_times", WorkingTimeController, except: [:new, :edit]
    resources "/teams", TeamController, except: [:new, :edit]
    resources "/user_teams", UserTeamController, except: [:new, :edit]
  end
end
