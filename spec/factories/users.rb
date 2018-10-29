# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    branch_id { FactoryBot.create(:branch).id }
    name { Faker::Name.name }
    age { Faker::Number.between(1, 100) }
    address { Faker::Address.street_address }
    father_name { Faker::Name.name }
    mother_name { Faker::Name.name }
    contact_no { Faker::Number.number(10) }
  end
end
