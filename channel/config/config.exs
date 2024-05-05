# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :channel,
  ecto_repos: [Channel.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :channel, ChannelWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: ChannelWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Channel.PubSub,
  live_view: [signing_salt: "nhvHCam5"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure the authentication keys
config :channel, Channel.Auth.Guardian,
  issuer: "chatai",
  allowed_algos: ["HS256"],
  secret_key: "ssSW552e+O/hWCF5ajmDaUulGYuwIb4lzIZlUvnGciCmC5/gg+9SwhfoSz/mTL6p"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
