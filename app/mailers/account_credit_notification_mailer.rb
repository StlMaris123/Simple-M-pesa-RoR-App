class AccountCreditNotificationMailer < ApplicationMailer
  def notify_user(recipient:, amount:)
    @user = recipient
    @amount = amount
    mail(to: @user.email, subject: 'Account Credit Notification')
  end
end
