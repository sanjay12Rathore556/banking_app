# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    user_id { FactoryBot.create(:user).id }
    account_no { Faker::Bank.account_number }
    account_type %w[saving current].sample
    balance Faker::Number.number(4)
  end
end
