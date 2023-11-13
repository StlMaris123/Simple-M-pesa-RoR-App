# frozen_string_literal: true

class ProcessStkCallback < ApplicationService
  private

  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def payload
    find_transaction

    if @transaction.present?
      process_stk_transaction
      @result = @transaction
    else
      errors.add(:base, 'Transaction not found')
    end
  end

  def find_transaction
    @transaction ||= AccountTransaction.find_by(checkout_request_id: stk_query_params[:CheckoutRequestID])
  end

  def stk_query_params
    case params.to_h.deep_symbolize_keys
    in {Body: {stkCallback: {MerchantRequestID: merchant_id, CheckoutRequestID: checkout_request_id}}}
      { MerchantRequestID: merchant_id, CheckoutRequestID: checkout_request_id }
    else
      { MerchantRequestID: nil, CheckoutRequestID: nil }
    end
  end

  def process_stk_transaction
    update_transaction_status
    update_account_balance
  end

  def update_transaction_status
    @transaction.update(transaction_status: 'completed')
  end

  def update_account_balance
    @transaction.account.update(
      balance: @transaction.account_balance + @transaction.amount
    )
  end
end
