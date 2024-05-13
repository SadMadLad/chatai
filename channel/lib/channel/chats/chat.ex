defmodule Channel.Chats.Chat do
  @moduledoc """
  (Live) Chats
  """

  use Ecto.Schema
  alias Channel.Chats.Message

  schema "chats" do
    field :chat_status, :integer
    field :chat_type, :integer, default: 0
    field :chat_title, :string
    field :latest_message_at, :native_datetime

    has_many :messages, Message

    timestamps(type: :utc_datetime, inserted_at: :created_at)
  end
end
