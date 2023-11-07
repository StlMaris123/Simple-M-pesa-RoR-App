# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authenticate_user

      def create
        outcome = CreateMessageService.call(
          channel: message_params[:channel],
          message: message_params[:message],
          scheduled_at: message_params[:scheduled_at]
        )

        if outcome.success?
          render json: { message: 'message successfully created' }, status: :created
        else
          render_unprocessable_entity(outcome.result)
        end
      end

      private

      def message_params
        params.require(:message).permit(:message, :scheduled_at, :channel)
      end
    end
  end
end
