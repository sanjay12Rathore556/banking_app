# frozen_string_literal: true

FactoryBot.define do
  factory :atm do
    bank_id { FactoryBot.create(:bank).id }
    name Faker::Name.name
    address Faker::Address.street_address
  end
end
