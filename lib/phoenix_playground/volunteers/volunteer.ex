defmodule PhoenixPlayground.Volunteers.Volunteer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "volunteers" do
    field :name, :string
    field :checked_out, :boolean, default: false
    field :phone, :string

    timestamps(type: :utc_datetime)
  end

  @phone ~r/^\d{3}[\s-.]?\d{3}[\s-.]?\d{4}$/

  @doc false
  def changeset(volunteer, attrs) do
    volunteer
    |> cast(attrs, [:checked_out, :name, :phone])
    |> validate_required([:checked_out, :name, :phone])
    |> validate_length(:name, min: 2, max: 100)
    |> validate_format(:phone, @phone, message: "must be a valid phone number")
  end
end
