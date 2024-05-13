defmodule ChannelWeb.ActiveChannel do
  @moduledoc """
  Associated Channel for registering user presence.
  """

  use ChannelWeb, :channel
  alias ChannelWeb.Presence

  def join("active:lobby", %{"token" => token, "name" => name, "avatar_url" => avatar_url}, socket) do
    send(self(), :after_join)
    {:ok, assign(socket, token: token, name: name, avatar_url: avatar_url)}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} =
      Presence.track(socket, socket.assigns.token, %{
        online_at: inspect(System.system_time(:second)),
        name: socket.assigns.name,
        avatar_url: socket.assigns.avatar_url,
        unique_identifier: socket.assigns.current_account.unique_identifier,
        username: socket.assigns.current_account.username
      })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end
end
