class Loan < ApplicationRecord
  belongs_to :branch
  belongs_to :user
  validates :loan_type,:interest,:time_period,:amount,presence: true
  validates :amount, numaricality: true
end
