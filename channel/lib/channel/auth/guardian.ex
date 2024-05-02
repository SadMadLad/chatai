defmodule Channel.Auth.Guardian do
  use Guardian, otp_app: :channel

  alias Channel.Auth
end
