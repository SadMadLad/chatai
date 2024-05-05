defmodule Channel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChannelWeb.Telemetry,
      Channel.Repo,
      {DNSCluster, query: Application.get_env(:channel, :dns_cluster_query) || :ignore},
      # Start a worker by calling: Channel.Worker.start_link(arg)
      # {Channel.Worker, arg},
      # Start to serve requests, typically the last entry
      {Phoenix.PubSub, name: Channel.PubSub},
      ChannelWeb.Presence,
      ChannelWeb.Endpoint,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Channel.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChannelWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
