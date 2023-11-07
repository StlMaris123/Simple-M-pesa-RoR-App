# frozen_string_literal: true

class CreateMessageService < ApplicationService
    attr_reader :channel, :message, :scheduled_at
  
    def initialize(channel:, message:, scheduled_at:)
      @channel = channel
      @message = message || 'Congratulations, your transaction is successful.'
      @scheduled_at = scheduled_at
    end
  
    def payload
      scheduled_message = ScheduledMessage.create(channel: channel, message: message, scheduled_at: scheduled_at)
  
      case channel
      when 'sms' then SmsAutomationJob.perform_later(scheduled_message, Current.user)
        # when 'email' then Email::SendgridClient.new.send_email
      end
  
      @result = scheduled_message
    end
  
    private
  
    def valid_channel?
      %w[sms email].include?(channel)
    end
  end
  