# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  phone                  :string
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validations
  validates :phone, phone: true
  validates :phone, presence: true#, uniqueness: true

  # Associations
  has_one :account
  has_many :account_transactions, through: :account
  has_many :sent_transactions, foreign_key: :sender_id, class_name: 'AccountTransaction'
  has_many :received_transactions, foreign_key: :recepient_id, class_name: 'AccountTransaction'
end
