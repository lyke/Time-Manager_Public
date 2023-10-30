defmodule TimeManagerWeb.UserJSON do
  alias TimeManager.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def show_time_credit(%{time_credit: time_credit}) do
    %{"time_credit"=> time_credit}
  end


  defp data(%User{} = user) do
    %{
      id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      password: user.password,
      role: "user",
      team: user.team
    }
  end
end

defmodule TimeManagerWeb.UserResult do
  @derive {Jason.Encoder, only: [:token, :user_id]}

  defstruct [:token, :user_id]
end
