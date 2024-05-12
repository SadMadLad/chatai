defmodule Channel.Auth.Account do
  use Ecto.Schema
  alias Channel.Auth.AccountToken

  schema "accounts" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :latest_message_at, :naive_datetime
    field :user_id, :integer
    field :unique_identifier, :binary_id

    has_many :account_tokens, AccountToken

    timestamps(type: :utc_datetime, inserted_at: :created_at)
  end
end
