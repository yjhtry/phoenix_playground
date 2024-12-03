defmodule PhoenixPlaygroundWeb.FilterLive do
  import Phoenix.HTML.Form, only: [options_for_select: 2]
  alias PhoenixPlayground.Boats
  use PhoenixPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        boats: Boats.list_boats(),
        type: "",
        prices: []
      )

    {:ok, socket, temporary_assigns: [boats: []]}
  end

  def render(assigns) do
    ~H"""
    <h1>Daily Boat Rentals</h1>
    <div id="filter">
      <form phx-change="filter">
        <div class="filters">
          <select name="type">
            <%= options_for_select(type_options(), @type) %>
          </select>
          <div class="prices">
            <%= for price <- ["$", "$$", "$$$"]  do %>
              <input type="hidden" name="prices[]" value="" />
              <%= price_checkbox(price: price, checked: price in @prices) %>
            <% end %>
          </div>
        </div>
      </form>

      <div class="boats">
        <%= for boat <- @boats do %>
          <div class="card">
            <img src={boat.image} />
            <div class="content">
              <div class="model">
                <%= boat.model %>
              </div>
              <div class="details">
                <span class="price">
                  <%= boat.price %>
                </span>
                <span class="type">
                  <%= boat.type %>
                </span>
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("filter", %{"type" => type, "prices" => prices}, socket) do
    params = [type: type, prices: Enum.filter(prices, &(&1 !== ""))]
    boats = Boats.list_boats(params)

    socket =
      assign(
        socket,
        params ++ [boats: boats]
      )

    {:noreply, socket}
  end

  defp price_checkbox(assigns) do
    assigns = Enum.into(assigns, %{})

    ~H"""
    <input type="checkbox" id={@price} name="prices[]" value={@price} checked={@checked} />
    <label for={@price}><%= @price %></label>
    """
  end

  defp type_options do
    [
      "All Types": "",
      Fishing: "fishing",
      Sporting: "sporting",
      Sailing: "sailing"
    ]
  end
end
