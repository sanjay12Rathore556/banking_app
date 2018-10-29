# frozen_string_literal: true

FactoryBot.define do
  factory :loan do
    user_id { FactoryBot.create(:user).id }
    loan_type %w[
      Education_Loan Home_Loan Personal_Loan Business_Loan Car_Loan
    ].sample
    amount { Faker::Number.number(5) }
    interest { Faker::Number.number(2) }
    time_period { Faker::Number.number(2) }
  end
end
