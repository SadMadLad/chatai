defmodule ChannelWeb.ChatChannel do
  @moduledoc """
  Channel to manage live chats
  """

  use ChannelWeb, :channel

  alias ChannelWeb.Presence
  alias Channel.Auth
  alias Channel.Chats

  def join("chat:" <> _chat_id, %{"token" => token, "name" => name, "avatar_url" => avatar_url}, socket) do
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

  def handle_in("create:message", %{"content" => content}, socket) do
    "chat:" <> chat_id = socket.topic

    chat = Chats.get_chat!(chat_id)
    case Chats.create_message(%{
      "account_id" => socket.assigns.current_account.id,
      "chat_id" => chat_id,
      "message" => content
    }) do
      {:ok, message} ->
        Chats.update_chat(chat, %{"latest_message_at" => message.created_at})
        Auth.update_account(socket.assigns.current_account, %{"latest_message_at" => message.created_at})
        broadcast!(socket, "create:message", %{"content" => content})
        {:noreply, socket}
      {:error, _} -> {:error, %{reason: "Content Must be present"}}
    end
  end
end
