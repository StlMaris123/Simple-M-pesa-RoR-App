# frozen_string_literal: true

class SmsAutomationJob < ApplicationJob
  def perform(recipient:, sender:, amount:)
    Sms::TwilioClient.new(
      recipient: recipient, sender: sender, amount: amount
    ).send_sms
  end
end
