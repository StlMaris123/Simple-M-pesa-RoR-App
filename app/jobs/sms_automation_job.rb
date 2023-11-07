# frozen_string_literal: true

class SmsAutomationJob < ApplicationJob
  def perform(message, recipient)
    Sms::TwilioClient.new(
      scheduled_message: message, recipient: recipient
    ).send_sms
  end
end
