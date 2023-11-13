class AccountNotificationJob < ApplicationJob
  def perform(recipient:, amount:)
    AccountCreditNotificationMailer.notify_user(recipient: recipient, amount: amount).deliver_now
  end
end
