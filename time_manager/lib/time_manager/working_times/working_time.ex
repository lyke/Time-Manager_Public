defmodule TimeManager.WorkingTimes.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "working_times" do
    field :start, :naive_datetime
    field :end, :naive_datetime
    field :fk_user, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :fk_user])
    |> validate_required([:start, :end, :fk_user])
  end
end
