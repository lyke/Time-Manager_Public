defmodule TimeManager.UserTasks do
  @moduledoc """
  The UserTasks context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo

  alias TimeManager.UserTasks.UserTask

  @doc """
  Returns the list of user_tasks.

  ## Examples

      iex> list_user_tasks()
      [%UserTask{}, ...]

  """
  def list_user_tasks do
    Repo.all(UserTask)
  end

  @doc """
  Gets a single user_task.

  Raises `Ecto.NoResultsError` if the User task does not exist.

  ## Examples

      iex> get_user_task!(123)
      %UserTask{}

      iex> get_user_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_task!(id), do: Repo.get!(UserTask, id)

  @doc """
  Creates a user_task.

  ## Examples

      iex> create_user_task(%{field: value})
      {:ok, %UserTask{}}

      iex> create_user_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_task(attrs \\ %{}) do
    %UserTask{}
    |> UserTask.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_task.

  ## Examples

      iex> update_user_task(user_task, %{field: new_value})
      {:ok, %UserTask{}}

      iex> update_user_task(user_task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_task(%UserTask{} = user_task, attrs) do
    user_task
    |> UserTask.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_task.

  ## Examples

      iex> delete_user_task(user_task)
      {:ok, %UserTask{}}

      iex> delete_user_task(user_task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_task(%UserTask{} = user_task) do
    Repo.delete(user_task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_task changes.

  ## Examples

      iex> change_user_task(user_task)
      %Ecto.Changeset{data: %UserTask{}}

  """
  def change_user_task(%UserTask{} = user_task, attrs \\ %{}) do
    UserTask.changeset(user_task, attrs)
  end
end
