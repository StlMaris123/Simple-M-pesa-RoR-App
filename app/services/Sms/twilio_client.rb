# frozen_string_literal: true

module Sms
  class TwilioClient
    attr_reader :recipient, :scheduled_message

    def initialize(scheduled_message:, recipient:)
      @recipient = recipient
      @scheduled_message = scheduled_message
    end

    def send_sms
      return deliver_sms_now! unless deliver_now?

      SmsAutomationJob.set(wait_until: scheduled_message.scheduled_at)
                      .perform_later(scheduled_message, recipient)
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

    def deliver_sms_now!
      client.api.account.messages.create(
        to: recipient.phone,
        from: phone_number,
        body: scheduled_message.message
      )
    end

    def deliver_now?
      return false unless scheduled_message.scheduled_at.present?

      scheduled_message.scheduled_at.present? && DateTime.parse(scheduled_message.scheduled_at.to_s) > Time.current
    end
  end
end
