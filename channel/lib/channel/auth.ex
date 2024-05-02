defmodule Channel.Auth do
  import Ecto.Query, warn: false
  alias Channel.Repo

  alias Channel.Auth.{Account, AccountToken}

  def list_accounts do
    Repo.all(Account)
  end

  def list_account_tokens do
    Repo.all(AccountToken)
  end

  def get_account!(id), do: Repo.get!(Account, id)

  def get_account_token!(id), do: Repo.get!(AccountToken, id) |> Repo.preload(:account)
end
