defmodule PhoenixPlaygroundWeb.PaginateLive do
  import Phoenix.HTML.Form, only: [options_for_select: 2]

  alias PhoenixPlayground.Donations
  use PhoenixPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [donations: []]}
  end

  def handle_params(%{"page" => page, "per_page" => per_page}, _uri, socket) do
    page = String.to_integer(page)
    per_page = String.to_integer(per_page)

    paginate_options = %{page: page, per_page: per_page}
    donations = Donations.list_donations(paginate: paginate_options)

    socket =
      assign(
        socket,
        options: paginate_options,
        donations: donations
      )

    {:noreply, socket}
  end

  def handle_params(_, _uri, socket) do
    socket =
      push_patch(socket,
        to: ~p"/paginate?#{get_default_options()}"
      )

    {:noreply, socket}
  end

  def handle_event("select-per-page", %{"per_page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    socket =
      push_patch(socket,
        to: ~p"/paginate?#{[page: socket.assigns.options.page, per_page: per_page]}"
      )

    {:noreply, socket}
  end

  defp expires_class(donation) do
    if Donations.almost_expired?(donation), do: "eat-now", else: "fresh"
  end

  defp get_default_options(), do: [page: 1, per_page: 5]
end
