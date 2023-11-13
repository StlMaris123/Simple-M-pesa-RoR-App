# frozen_string_literal: true

# app/services/fund_transfer_service.rb
class FundsTransferService < ApplicationService
  private

  attr_reader :sender, :recipient, :amount

  def initialize(sender:, recipient:, amount:)
    @sender = sender
    @recipient = recipient
    @amount = amount
  end

  def payload
    if sender_account.balance >= amount
      transfer_funds
      @result = create_transaction_records
    else
      errors.add(:base, 'Insufficient balance')
    end
  end

  def transfer_funds
    update_account_details

    create_transaction_records
  end

  def update_account_details
    update_sender_account_balance
    update_recipient_account_balance
  end

  def update_sender_account_balance
    sender_account.update!(balance: sender_account.balance - amount)
  end

  def sender_account = sender.account

  def update_recipient_account_balance
    recipient_account.update!(balance: recipient_account.balance + amount)
  end

  def recipient_account = recipient.account

  def create_transaction_records
    AccountTransaction.transaction do
      AccountTransaction.create!(
        amount: -@amount,
        transaction_type: 'debit',
        account: @sender.account,
        sender_id: @sender.id,
        recepient_id: @recipient.id,
        reference_number: generate_reference_number,
        transaction_status: 'completed'
      )

      AccountTransaction.create!(
        amount: @amount,
        transaction_type: 'credit',
        account: @recipient.account,
        sender_id: @sender.id,
        recepient_id: @recipient.id,
        reference_number: generate_reference_number,
        transaction_status: 'completed'
      )
    end
  end

  def generate_reference_number
    SecureRandom.base58(12)
  end
end
