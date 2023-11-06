# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authenticate_user!

      def create
        TwilioClient.new.send_sms(current_user)
        render json: { message: 'message successfully created' }, status: :created
      rescue Twilio::REST::RestError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end
end
