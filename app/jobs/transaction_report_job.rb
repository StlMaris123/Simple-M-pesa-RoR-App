# frozen_string_literal: true

class TransactionReportJob < ApplicationJob
  def perform(user:, transaction_ids:)
    transactions = AccountTransaction.where(id: transaction_ids.compact)
    ReportMailer.send_report(user: user, transactions: transactions).deliver_later
  end
end
