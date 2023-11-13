module Api
  module V1
    class StkPushTransactionsController < ApplicationController
      skip_before_action :authenticate_user
      before_action :find_user, only: :stk_push

      def stk_push
        response = CreateAccountTransaction.call(params: params.to_unsafe_h, user: @user)

        if response.success?
          render json: response.result, status: :created
        else
          render json: response.errors, status: :unprocessable_entity
        end
      end

      def callback
        response = ProcessStkCallback.call(params: params.to_unsafe_h)

        if response.success?
          render json: { message: 'Success' }, status: :ok
        else
          render json: { message: 'Failure' }, status: :ok
        end
      end

      private

      def find_user
        @user ||= User.find_by(phone: params[:phone_number])
      end

      def render_response(transaction, message, status)
        if transaction&.persisted?
          render(json: { message: message }, status: status)
        else
          render json: { message: 'Failed to save transaction' }, status: :internal_server_error
        end
      end
    end
  end
end
