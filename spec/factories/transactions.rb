# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    atm_id { FactoryBot.create(:atm).id }
    account_id { FactoryBot.create(:account).id }
    amount Faker::Number.number(2)
    transaction_type %w[withdraw deposit].sample
  end
end
