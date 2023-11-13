# == Schema Information
#
# Table name: account_transactions
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(, )
#  reference_number    :string
#  transaction_status  :string
#  transaction_type    :string
#  checkout_request_id :string
#  merchant_request_id :string
#  account_id          :bigint
#  sender_id           :bigint
#  recepient_id        :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class AccountTransaction < ApplicationRecord
  enum transaction_status: {
    pending:   'pending',
    completed: 'completed',
    failed:    'failed'
  }

  enum transaction_type: {
    credit: 'credit',
    debit:  'debit'
  }

  after_create_commit :notify_user, if: :credit?

  belongs_to :account, optional: true
  belongs_to :sender, optional: true, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, optional: true, class_name: 'User', foreign_key: 'recepient_id'

  attribute :transaction_status, :string, default: 'pending'
  delegate :balance, to: :account, prefix: true, allow_nil: true

  scope :for_date_range, ->(start_date, end_date) { where(created_at: start_date..end_date) }

  private

  def notify_user
    SmsAutomationJob.perform_later(recipient: recipient, sender: sender, amount: amount)
    AccountNotificationJob.perform_later(recipient: recipient, amount: amount)
  end
end
