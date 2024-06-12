defmodule Channel.Auth.Account do
  @moduledoc """
  User Account module.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Channel.Auth.AccountToken

  schema "accounts" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :latest_message_at, :utc_datetime
    field :user_id, :integer

    has_many :account_tokens, AccountToken

    timestamps(type: :utc_datetime, inserted_at: :created_at)
  end

  def changeset(account, attrs) do
    account_cols = [:username, :first_name, :last_name, :latest_message_at, :user_id]

    account
    |> cast(attrs, account_cols)
    |> validate_required(account_cols)
  end
end
