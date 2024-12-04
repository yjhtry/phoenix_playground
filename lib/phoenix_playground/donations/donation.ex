defmodule PhoenixPlayground.Donations.Donation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "donations" do
    field :item, :string
    field :days_until_expires, :integer
    field :emoji, :string
    field :quantity, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(donation, attrs) do
    donation
    |> cast(attrs, [:days_until_expires, :emoji, :item, :quantity])
    |> validate_required([:days_until_expires, :emoji, :item, :quantity])
  end
end
