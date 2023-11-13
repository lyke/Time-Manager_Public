defmodule TimeManager.UserTasks.UserTask do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_tasks" do

    # field :user_id, :binary_id
    # field :task_id, :binary_id
    belongs_to :user, TimeManager.Accounts.User
    belongs_to :task, TimeManager.Plannings.Task

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_task, attrs) do
    user_task
    |> cast(attrs, [:user_id, :task_id])
    |> validate_required([:user_id, :task_id])
  end
end
