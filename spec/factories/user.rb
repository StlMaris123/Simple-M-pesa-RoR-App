FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      phone { '+254712345678'}
      password { 'password' }
      password_confirmation { 'password' }
    end
  end