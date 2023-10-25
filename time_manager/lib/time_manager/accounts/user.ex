defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :password, :string
    field :role, :string
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    field :team, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :password, :role, :team])
    |> validate_required([:firstname, :lastname, :email, :password, :role])
  end
end
