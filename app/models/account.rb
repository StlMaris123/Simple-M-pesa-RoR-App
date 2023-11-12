# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  balance        :decimal(, )
#  user_id        :bigint           not null
#  account_number :string
#  account_status :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Account < ApplicationRecord
  belongs_to :user
  has_many :account_transactions, dependent: :destroy
end
