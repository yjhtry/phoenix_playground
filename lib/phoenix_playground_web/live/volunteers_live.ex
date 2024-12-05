defmodule PhoenixPlaygroundWeb.VolunteersLive do
  alias PhoenixPlayground.Volunteers.Volunteer
  alias PhoenixPlayground.Volunteers
  use PhoenixPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        changeset: Volunteers.change_volunteer(%Volunteer{}),
        volunteers: Volunteers.list_volunteers()
      )

    {:ok, socket}
  end

  def handle_event("validate", %{"volunteer" => params}, socket) do
    changeset = Volunteers.change_volunteer(%Volunteer{}, params) |> Map.put(:action, :insert)

    socket = update(socket, :changeset, fn _ -> changeset end)
    {:noreply, socket}
  end

  def handle_event("save", %{"volunteer" => params}, socket) do
    case Volunteers.create_volunteer(params) do
      {:ok, %Volunteer{} = volunteer} ->
        socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = update(socket, :changeset, fn _ -> changeset end)
        {:noreply, socket}
    end
  end

  def handle_event("toggle-status", %{"id" => id}, socket) do
    id = String.to_integer(id)
    volunteer = Volunteers.get_volunteer!(id)

    {:ok, _volunteer} =
      Volunteers.update_volunteer(volunteer, %{checked_out: !volunteer.checked_out})

    volunteers = Volunteers.list_volunteers()
    socket = assign(socket, volunteers: volunteers)

    {:noreply, socket}
  end
end
