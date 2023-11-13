module Api
  module V1
    class AccountTransactionsController < ApplicationController
      before_action :find_user, only: :create

      def create
        response = FundsTransferService.call(sender: sender, recipient: @user, amount: amount)
        if response.success?
            render json: { message: 'Funds transferred successfully' }, status: :ok
        else
          render json: { error: response.errors }, status: :unprocessable_entity
        end
      end

      private

      def find_user
        @user ||= User.find_by(phone: params[:phone_number])
      end

      def amount = params.fetch(:amount).to_f
      def sender = Current.user
    end
  end
end
