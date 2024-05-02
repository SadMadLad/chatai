defmodule Channel.AuthTest do
  use Channel.DataCase

  alias Channel.Auth

  describe "accounts" do
    alias Channel.Auth.Account

    import Channel.AuthFixtures

    @invalid_attrs %{username: nil, first_name: nil, last_name: nil, latest_message_at: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Auth.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Auth.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{username: "some username", first_name: "some first_name", last_name: "some last_name", latest_message_at: ~N[2024-05-01 20:55:00]}

      assert {:ok, %Account{} = account} = Auth.create_account(valid_attrs)
      assert account.username == "some username"
      assert account.first_name == "some first_name"
      assert account.last_name == "some last_name"
      assert account.latest_message_at == ~N[2024-05-01 20:55:00]
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{username: "some updated username", first_name: "some updated first_name", last_name: "some updated last_name", latest_message_at: ~N[2024-05-02 20:55:00]}

      assert {:ok, %Account{} = account} = Auth.update_account(account, update_attrs)
      assert account.username == "some updated username"
      assert account.first_name == "some updated first_name"
      assert account.last_name == "some updated last_name"
      assert account.latest_message_at == ~N[2024-05-02 20:55:00]
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_account(account, @invalid_attrs)
      assert account == Auth.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Auth.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Auth.change_account(account)
    end
  end
end
