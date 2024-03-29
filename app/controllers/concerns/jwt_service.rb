# frozen_string_literal: true

module JwtService
  HMAC_SECRET = ENV.fetch('HMAC_SECRET', nil).freeze

  def encode(payload)
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  def decode(token)
    JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' }).first.with_indifferent_access
  end
end
