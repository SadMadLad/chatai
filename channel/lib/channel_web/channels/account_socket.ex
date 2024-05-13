defmodule ChannelWeb.AccountSocket do
  use Phoenix.Socket
  alias Channel.Auth
  alias ChannelWeb.{ActiveChannel, ChatChannel}

  # A Socket handler
  #
  # It's possible to control the websocket connection and
  # assign values that can be accessed by your channel topics.

  ## Channels

  channel "active:*", ActiveChannel
  channel "chat:*", ChatChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a account. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :account_id, verified_account_id)}
  #
  # To deny connection, return `:error` or `{:error, term}`. To control the
  # response the client receives in that case, [define an error handler in the
  # websocket
  # configuration](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#socket/3-websocket-configuration).
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(%{"token" => token}, socket, _connect_info) do
    case Auth.get_account_by_token!(token) do
      {:ok, account_token, _claims} -> {:ok, assign(socket, :current_account, account_token.account) }
      {:error, _reason} -> :error
    end
  end

  # Socket IDs are topics that allow you to identify all sockets for a given account:
  #
  #     def id(socket), do: "account_socket:#{socket.assigns.account_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given account:
  #
  #     Elixir.ChannelWeb.Endpoint.broadcast("account_socket:#{account.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(_socket), do: nil
end
