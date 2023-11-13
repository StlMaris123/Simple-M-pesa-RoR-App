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
require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
end
