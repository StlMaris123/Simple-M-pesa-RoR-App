# frozen_string_literal: true

class TransactionReportJob < ApplicationJob
  def perform(user_id:, transaction_ids:)
    user = User.find_by(id: user_id)
    transactions = AccountTransaction.where(id: transaction_ids.compact).to_a
    ReportMailer.send_report(user: user, transactions: transactions).deliver_later
  end
end
