defmodule Channel.Auth do
  import Ecto.Query, warn: false

  alias Channel.Repo
  alias Channel.Auth.{Account, AccountToken, Guardian}

  def list_accounts do
    Repo.all(Account)
  end

  def list_account_tokens do
    Repo.all(AccountToken)
  end

  def get_account!(id), do: Repo.get!(Account, id)

  def get_account_token!(id), do: Repo.get!(AccountToken, id) |> Repo.preload(:account)

  def get_account_by_token!(token), do: Guardian.resource_from_token(token)
end
