# == Schema Information
#
# Table name: account_transactions
#
#  id                 :bigint           not null, primary key
#  amount             :decimal(, )
#  reference_number   :string
#  transaction_status :string
#  transaction_type   :string
#  account_id         :bigint           not null
#  sender_id          :bigint           not null
#  recepient_id       :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
end
