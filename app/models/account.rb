# frozen_string_literal: true

# Description/Explanation of Person class
class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates :balance, :account_type, presence: true
  validates :account_no,
            numericality: { only_integer: true },
            uniqueness: true
  validates :account_type, inclusion: { in: %w[saving current] }
  validate :check_valid_balance
end
private
def check_valid_balance
  errors.add(:base, 'balance should be grater than 1000') if
  balance.nil? || balance < 1000
end
