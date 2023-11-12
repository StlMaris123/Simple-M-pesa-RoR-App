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
class AccountTransaction < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :sender, optional: true, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, optional: true, class_name: 'User', foreign_key: 'recepient_id'
end
