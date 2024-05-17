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
    account = socket.assigns.current_account

    case Chats.create_message(%{
      "account_id" => account.id,
      "chat_id" => chat_id,
      "content" => content
    }) do
      {:ok, message} ->
        Chats.update_chat(chat, %{"latest_message_at" => message.created_at})
        Auth.update_account(account, %{"latest_message_at" => message.created_at})
        broadcast!(socket, "create:message", new_message_payload(socket, message, account))
        {:noreply, socket}
      {:error, _} -> {:noreply, socket}
    end
  end

  defp new_message_payload(socket, message, account) do
    %{
      "id" => message.id,
      "avatar_url" => socket.assigns.avatar_url,
      "content" => message.content,
      "created_at" => message.created_at,
      "sender" => socket.assigns.name,
      "sender_identifier" => account.unique_identifier
    }
  end
end
