defmodule Channel.Repo do
  use Ecto.Repo,
    otp_app: :channel,
    adapter: Ecto.Adapters.Postgres
end
