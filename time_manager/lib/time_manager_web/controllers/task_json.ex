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

  def show_without_users(%{task: task}) do
    %{data: data_no_users(task)}
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

  defp data_no_users(%Task{} = task) do
    %{
      id: task.id,
      name: task.name,
      description: task.description,
      type: task.type,
      status: task.status,
      start_date: task.start_date,
      end_date: task.end_date,
    }
end
end
