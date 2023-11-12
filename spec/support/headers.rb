# frozen_string_literal: true

module Headers
  module Helpers
    def global_headers(user = User.find_by_email('user@test.com'))
      token_command = Authentication::AuthenticateUserService.new(user.email, 'password').call

      return unless token_command.success?

      {
        'Authorization' => Authentication::AuthenticateUserService
          .call(
            user.email,
            'password'
          ).result
      }
    end
  end
end
