# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: :create
      before_action :find_user, except: %I[index create]

      def show
        render json: @user, status: :ok
      end

      def index
        page_number = params.fetch(:page, 1)
        per_page = params.fetch(:per_page, 10)

        @users = User.paginate(page: page_number, per_page: per_page)
        render json: @users, status: :ok
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render_unprocessable_entity(@user)
        end
      end

      def update
        if @user.update(user_params.except(:password, :password_confirmation))
          render json: @user, status: :ok
        else
          render_unprocessable_entity(@user)
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def find_user
        @user ||= User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:phone, :password, :first_name, :email, :last_name)
      end
    end
  end
end
