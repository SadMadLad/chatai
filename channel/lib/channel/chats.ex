defmodule Channel.Chats do
  @moduledoc """
  Module for managing chats and messages
  """

  import Ecto.Query, warn: false

  alias Channel.Chats.{Chat, Message}
  alias Channel.Repo

  # Chats

  def list_chats, do: Repo.all(Chat)

  def get_chat!(id), do: Repo.get!(Chat, id)

  def update_chat(%Chat{} = chat, attrs) do
    chat
    |> Chat.changeset(attrs)
    |> Repo.update
  end

  # Messages

  def list_messages, do: Repo.all(Message)

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert
  end
end
