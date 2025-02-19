defmodule PhoenixPlaygroundWeb.LightLive do
  use PhoenixPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 0)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>

      <button phx-click="off">
        <img src="images/light-off.svg" />
      </button>

      <button phx-click="down">
        <img src="images/down.svg" />
      </button>

      <button phx-click="up">
        <img src="images/up.svg" />
      </button>

      <button phx-click="on">
        <img src="images/light-on.svg" />
      </button>
    </div>
    """
  end

  def handle_event("off", _value, socket) do
    {:noreply, assign(socket, brightness: 0)}
  end

  def handle_event("on", _value, socket) do
    {:noreply, assign(socket, brightness: 100)}
  end

  def handle_event("up", _value, socket) do
    {:noreply, update(socket, :brightness, &(&1 + 10))}
  end

  def handle_event("down", _value, socket) do
    {:noreply, update(socket, :brightness, &(&1 - 10))}
  end
end
