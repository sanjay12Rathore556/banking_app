# frozen_string_literal: true

FactoryBot.define do
  factory :manager do
    branch_id { FactoryBot.create(:branch).id }
    name { Faker::Name.name }
    contact_no { Faker::Number.number(10) }
  end
end
