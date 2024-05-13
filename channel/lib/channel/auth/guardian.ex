defmodule Channel.Auth.Guardian do
  @moduledoc """
  JWT module for User Authentication.
  """

  use Guardian, otp_app: :channel
  alias Channel.Auth

  def subject_for_token(account_token, _claims) do
    {:ok, to_string(account_token.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    account_token = Auth.get_account_token!(id)
    {:ok, account_token}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
