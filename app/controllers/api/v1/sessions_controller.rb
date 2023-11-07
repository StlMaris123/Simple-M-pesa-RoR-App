# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user

      def create
        token_command = Authentication::AuthenticateUserService.call(
          *params[:auth].slice(:email, :password).values
        )

        if token_command.success?
          render json: token_command.result, status: :ok
        else
          render json: { error: token_command.errors }, status: :unauthorized
        end
      end
    end
  end
end
