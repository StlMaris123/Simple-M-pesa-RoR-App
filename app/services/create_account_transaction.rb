class CreateAccountTransaction < ApplicationService
  private

  attr_reader :user, :params

  def initialize(params:, user:)
    @user = user
    @params = params
  end

  def payload
    stk_response = Mpesa::StkPush.new(amount, phone_number).simulate

    if stk_response.success?
      @result = create_account_transaction(stk_response)
    else
      errors.add(:base, stk_response.body)
    end
  end

  def amount       = params.fetch(:amount, 0)
  def phone_number = params.fetch(:phone_number, Rails.application.credentials.mpesa.phone_number)

  def stk_response
    @stk_response ||= Mpesa::StkPush.new(amount, phone_number).simulate
  end

  def create_account_transaction(stk_response)
    return unless @user && @user.account.present?

    AccountTransaction.create(
      transaction_type: 'c2b',
      checkout_request_id: stk_response.body['CheckoutRequestID'],
      merchant_request_id: stk_response.body['MerchantRequestID'],
      account: @user.account,
      recipient: @user,
      amount: params['amount']
    )
  end
end
