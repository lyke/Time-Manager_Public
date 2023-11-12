defmodule TimeManagerWeb.ClockJSON do
  alias TimeManager.Clocks.Clock

  @doc """
  Renders a list of clocks.
  """
  def index(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: data(clock))}
  end

  def index_per_user_per_day(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: data(clock))}
  end
  @doc """
  Renders the list of clock linked with a user.
  """
  def show(%{clock: clock}) do
    %{data: data(clock)}
  end

  defp data(%Clock{} = clock) do
    %{
      id: clock.id,
      time: clock.time,
      status: clock.status,
      fk_user: clock.fk_user
    }
  end
end
