# frozen_string_literal: true

# Description/Explanation of Person class
class Loan < ApplicationRecord
  belongs_to :user
  validates :loan_type, :interest, :time_period, :amount, presence: true
  validates :amount, :interest, :time_period, numericality: true
  validates :loan_type, inclusion: {
    in: %w[Education_Loan Home_Loan Personal_Loan Business_Loan Car_Loan]
  }
end
