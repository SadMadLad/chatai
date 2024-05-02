defmodule Channel.AuthFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Channel.Auth` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name",
        latest_message_at: ~N[2024-05-01 20:55:00],
        username: "some username"
      })
      |> Channel.Auth.create_account()

    account
  end
end
