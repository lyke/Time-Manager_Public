defmodule TimeManagerWeb.UserTaskJSON do
  alias TimeManager.UserTasks.UserTask

  @doc """
  Renders a list of user_tasks.
  """
  def index(%{user_tasks: user_tasks}) do
    %{data: for(user_task <- user_tasks, do: data(user_task))}
  end

  @doc """
  Renders a single user_task.
  """
  def show(%{user_task: user_task}) do
    %{data: data(user_task)}
  end

  defp data(%UserTask{} = user_task) do
    %{
      id: user_task.id,
      user: user_task.user_id,
      task: user_task.task_id
    }
  end
end
