# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: :create

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render_unprocessable_entity(@user)
        end
      end

      private

      def user_params
        params
          .require(:user).permit(:phone, :password, :name, :email)
      end
    end
  end
end
