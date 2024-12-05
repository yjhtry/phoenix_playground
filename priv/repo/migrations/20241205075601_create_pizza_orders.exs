defmodule PhoenixPlayground.Repo.Migrations.CreatePizzaOrders do
  use Ecto.Migration

  def change do
    create table(:pizza_orders) do
      add :pizza, :string
      add :username, :string

      timestamps(type: :utc_datetime)
    end
  end
end
