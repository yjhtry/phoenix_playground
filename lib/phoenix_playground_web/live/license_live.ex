defmodule PhoenixPlaygroundWeb.LicenseLive do
  alias PhoenixPlayground.License
  use PhoenixPlaygroundWeb, :live_view

  import Number.Currency

  def mount(_params, _session, sockect) do
    sockect = assign(sockect, seats: 3, amount: License.calculate(3))
    {:ok, sockect}
  end

  def render(assigns) do
    ~H"""
    <h1>Team License</h1>
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <img src="images/license.svg" />
            <span>
              Your license is currently for <strong><%= @seats %></strong> seats.
            </span>
          </div>

          <form phx-change="update">
            <input type="range" min="1" max="10" name="seats" value={@seats} />
          </form>

          <div class="amount">
            <%= number_to_currency(@amount) %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)

    socket =
      assign(
        socket,
        seats: seats,
        amount: License.calculate(seats)
      )

    {:noreply, socket}
  end
end
