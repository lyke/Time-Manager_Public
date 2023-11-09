defmodule TimeManagerWeb.TaskJSON do
  alias TimeManager.Plannings.Task

  @doc """
  Renders a list of tasks.
  """
  def index(%{tasks: tasks}) do
    %{data: for(task <- tasks, do: data(task))}
  end

  @doc """
  Renders a single task.
  """
  def show(%{task: task}) do
    %{data: data(task)}
  end

  defp data(%Task{} = task) do
    %{
      id: task.id,
      name: task.name,
      description: task.description,
      type: task.type,
      status: task.status,
      start_date: task.start_date,
      end_date: task.end_date,
      users: task.users
    }
  end
end
