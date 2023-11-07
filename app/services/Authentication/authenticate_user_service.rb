# frozen_string_literal: true

module Authentication
  class AuthenticateUserService < ApplicationService
    private

    attr_reader :email, :password

    def initialize(email, password)
      @email    = email
      @password = password
    end

    def payload
      if user&.valid_password?(password)
        @result = JwtService.encode(contents)
      else
        errors.add(:base, 'invalid credentials')
      end
    end

    def user
      @user ||= User.find_by(email: email)
    end

    def contents
      {
        email: user.email,
        user_id: user.id,
        exp: 24.hours.from_now.to_i
      }
    end
  end
end
