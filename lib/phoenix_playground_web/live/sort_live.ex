defmodule PhoenixPlaygroundWeb.SortLive do
  import Phoenix.HTML.Form, only: [options_for_select: 2]

  alias PhoenixPlayground.Donations
  use PhoenixPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [donations: []]}
  end

  def handle_params(params, _uri, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")
    sort_by = (params["sort_by"] || "id") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}

    donations = Donations.list_donations(paginate: paginate_options, sort: sort_options)

    socket =
      assign(
        socket,
        options: Map.merge(paginate_options, sort_options),
        donations: donations
      )

    {:noreply, socket}
  end

  def handle_event("select-per-page", %{"per_page" => per_page}, socket) do
    per_page = String.to_integer(per_page)
    options = Map.put(socket.assigns.options, "per_page", per_page)

    socket =
      push_patch(socket,
        to: link_path(options)
      )

    {:noreply, socket}
  end

  def handle_event("sort", _, socket) do
    {:noreply, socket}
  end

  defp expires_class(donation) do
    if Donations.almost_expired?(donation), do: "eat-now", else: "fresh"
  end

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

  defp link_path(options) do
    params = Enum.into(options, [])

    ~p"/sort?#{params}"
  end
end
