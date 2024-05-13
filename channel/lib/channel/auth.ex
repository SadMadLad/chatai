defmodule Channel.Auth do
  @moduledoc """
  Module for managing User authentication - Accounts, Users and Account Tokens.
  """

  import Ecto.Query, warn: false

  alias Channel.Repo
  alias Channel.Auth.{Account, AccountToken, Guardian}

  # Account

  def list_accounts, do: Repo.all(Account)

  def get_account!(id), do: Repo.get!(Account, id)

  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update
  end

  # Account Tokens

  def list_account_tokens, do: Repo.all(AccountToken)

  def get_account_token!(id), do: Repo.get!(AccountToken, id) |> Repo.preload(:account)

  def get_account_by_token!(token), do: Guardian.resource_from_token(token)
end
