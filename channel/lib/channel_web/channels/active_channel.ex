defmodule ChannelWeb.ActiveChannel do
  use ChannelWeb, :channel
  alias ChannelWeb.Presence

  def join("active:lobby", %{"token" => token}, socket) do
    send(self(), :after_join)
    {:ok, assign(socket, :token, token)}
  end

  def handle_info(:after_join, socket) do
    first_name = socket.assigns.current_account.first_name
    last_name = socket.assigns.current_account.last_name

    {:ok, _} =
      Presence.track(socket, socket.assigns.token, %{
        online_at: inspect(System.system_time(:second)),
        name: first_name <> " " <> last_name,
        id: socket.assigns.current_account.id
      })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end
end
