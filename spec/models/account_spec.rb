# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  balance        :decimal(, )      default(0.0)
#  user_id        :bigint           not null
#  account_number :string
#  account_status :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Account, type: :model do
end
