# frozen_string_literal: true

FactoryBot.define do
  factory :bank do
    name { Faker::Bank.name }
    contact_no { Faker::Number.number(10) }
  end
end
