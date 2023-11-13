class ReportMailer < ApplicationMailer
  def send_report(user:, transactions:)
    @user = user
    @transactions = transactions

    mail(to: user.email, subject: 'Transaction Report')
  end
end
