# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone { '+254712345678' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :default_user, class: 'User' do
    first_name { 'User' }
    last_name { 'Test' }
    phone { '+254712987654' }
    password { 'password' }
    email { 'user@test.com' }
  end
end
