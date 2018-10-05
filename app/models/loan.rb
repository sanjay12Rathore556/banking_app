class Loan < ApplicationRecord
  belongs_to :branch
  belongs_to :user
  validates :loan_type,:interest,:time_period,:amount,presence: true
  validates :amount, numaricality: true
  validates :loan_type, inclusion: { in: %w(Education_Loan Home_Loan Personal_loan Business_loan Car_Loan)}
end
