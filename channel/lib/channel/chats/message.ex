defmodule Channel.Chats.Message do
  @moduledoc """
  Chat Messages
  """

  use Ecto.Schema
  alias Channel.{Auth.Account, Chats.Chat}

  schema "messages" do
    field :role, :integer, default: 0
    field :content, :

    belongs_to :account, Account
    belongs_to :chat, Chat
  end
end
