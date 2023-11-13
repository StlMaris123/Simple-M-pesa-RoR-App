# Preview all emails at http://localhost:3000/rails/mailers/account_credit_notification
class AccountCreditNotificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/account_credit_notification/notify_user
  def notify_user
    AccountCreditNotificationMailer.notify_user
  end

end
