defmodule PhoenixPlayground.Repo.Migrations.CreateDonations do
  use Ecto.Migration

  def change do
    create table(:donations) do
      add :days_until_expires, :integer
      add :emoji, :string
      add :item, :string
      add :quantity, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
