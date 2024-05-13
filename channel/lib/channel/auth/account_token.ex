defmodule Channel.Auth.AccountToken do
  @moduledoc """
  Account's Account Token module.
  """

  use Ecto.Schema
  alias Channel.Auth.Account

  schema "account_tokens" do
    field :scope, :integer

    belongs_to :account, Account

    timestamps(type: :utc_datetime, inserted_at: :created_at)
  end
end
