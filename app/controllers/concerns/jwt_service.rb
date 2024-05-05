# frozen_string_literal: true

# Jwt auth for Api related stuff.
module JwtService
  HMAC_SECRET = ENV.fetch('HMAC_SECRET', nil).freeze
  ALGORITHM = 'HS256'

  def default_options
    {
      aud: 'chatai', exp: 56.days.from_now.to_time.to_i, iat: DateTime.now.to_time.to_i,
      iss: 'chatai', jit: SecureRandom.uuid, typ: 'access', nbf: DateTime.now.to_time.to_i - 1
    }.freeze
  end

  def encode(payload)
    JWT.encode(default_options.merge(sub: payload.to_s), HMAC_SECRET, ALGORITHM, alg: ALGORITHM, typ: 'JWT')
  end

  def decode(token)
    JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' }).first.with_indifferent_access
  end
end
