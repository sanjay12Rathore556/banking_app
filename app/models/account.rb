class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates :balance,:account_type,presence: true
  validates :account_no,numericality: {only_integer: true},uniqueness: true
  validates :account_type, inclusion: { in: %w(saving current)}
  validate :check_valid_balance
end
private
  def check_valid_balance
    if self.balance < 1000
      errors.add(:base, "For create an account your balance should be grater than 1000")
    end
end