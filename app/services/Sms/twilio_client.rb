# frozen_string_literal: true

module Sms
  class TwilioClient
    attr_reader :recipient, :sender, :amount

    def initialize(recipient:, sender:, amount:)
      @recipient = recipient
      @sender = sender
      @amount = amount
    end

    def send_sms
      create_message
      sms_call
    end

    private

    def client
      @client ||= Twilio::REST::Client.new(
        Rails.application.credentials.twilio.account_sid,
        Rails.application.credentials.twilio.auth_token
      )
    end

    def phone_number
      Rails.application.credentials.twilio.phone_number
    end

    def sms_call
      client.api.account.messages.create(
        to: recipient.phone,
        from: phone_number,
        body: @message.message
      )
    end

    def create_message
      message = "Congragulations!! You have recieved #{amount} from #{sender.first_name}"
      @message = Message.create(channel: 'sms', message: message)
    end
  end
end
