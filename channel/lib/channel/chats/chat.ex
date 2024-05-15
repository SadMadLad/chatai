defmodule Channel.Chats.Chat do
  @moduledoc """
  (Live) Chats
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Channel.Chats.Message

  schema "chats" do
    field :chat_description, :string
    field :chat_status, :integer
    field :chat_title, :string
    field :chat_type, :integer, default: 0
    field :latest_message_at, :utc_datetime

    has_many :messages, Message

    timestamps(type: :utc_datetime, inserted_at: :created_at)
  end

  def changeset(chat, attrs) do
    chat_cols = [:chat_description, :chat_status, :chat_title, :chat_type, :latest_message_at]

    chat
    |> cast(attrs, chat_cols)
    |> validate_required(chat_cols)
  end
end
