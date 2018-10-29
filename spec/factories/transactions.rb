# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.number(2) }
    transaction_type %w[withdraw deposit].sample
  end
end
