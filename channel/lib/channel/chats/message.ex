defmodule Channel.Chats.Message do
  @moduledoc """
  Chat Messages
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Channel.{Auth.Account, Chats.Chat}

  schema "messages" do
    field :role, :integer, default: 0
    field :content, :string

    belongs_to :account, Account
    belongs_to :chat, Chat

    timestamps(type: :utc_datetime, inserted_at: :created_at)
  end

  def changeset(message, attrs) do
    message_cols = [:chat_id, :account_id, :content]

    message
    |> cast(attrs, message_cols)
    |> validate_required(message_cols)
  end
end
