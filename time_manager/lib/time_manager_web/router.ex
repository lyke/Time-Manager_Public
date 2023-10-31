defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    post "/login", UserController, :login
    resources "/clocks", ClockController, except: [:new, :edit, :index, :update, :delete]
    get "/clocks", ClockController, :index
    resources "/working_times", WorkingTimeController, except: [:new, :edit]
    resources "/teams", TeamController, except: [:new, :edit]
    resources "/user_teams", UserTeamController, except: [:new, :edit]
  end
end
