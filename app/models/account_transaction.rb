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
  after_create :send_sms_if_credit, :send_email_if_credit

  belongs_to :account, optional: true
  belongs_to :sender, optional: true, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, optional: true, class_name: 'User', foreign_key: 'recepient_id'

  private

  def send_sms_if_credit
    if credit_transaction?
      SmsAutomationJob.perform_later(recipient: recipient, sender: sender, amount: amount)
      AccountNotificationJob.perform_later(recipient: recipient, amount: amount)
    end
  end

  def send_email_if_credit
    if credit_transaction?
      AccountNotificationJob.perform_later(recipient: recipient, amount: amount)
    end
  end

  def credit_transaction?
    transaction_type == 'credit'
  end
end
