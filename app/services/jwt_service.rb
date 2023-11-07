# frozen_string_literal: true

class JwtService
  def self.encode(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key, 'HS256')
  end

  def self.decode(token)
    body, =
      JWT.decode(
        token,
        Rails.application.credentials.secret_key,
        true,
        algorithm: 'HS256'
      )
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature, JWT::VerificationError
    nil
  end
end
