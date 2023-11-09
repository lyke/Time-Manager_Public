defmodule TimeManager.Plannings.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:id, :name, :status, :type, :description, :start_date, :end_date]}
  schema "tasks" do
    field :name, :string
    field :status, :boolean, default: false
    field :type, :string
    field :description, :string
    field :start_date, :naive_datetime
    field :end_date, :naive_datetime
    has_many :user_tasks, TimeManager.UserTasks.UserTask
    many_to_many :users, TimeManager.Accounts.User, join_through: TimeManager.UserTasks.UserTask

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :type, :status, :start_date, :end_date])
    |> validate_required([:name, :description, :type, :status, :start_date, :end_date])
  end
end
