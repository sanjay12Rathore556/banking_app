class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates :balance,:account_type,presence: true
  validates :account_no,numericality: {only_integer: true},uniqueness: true
  validates :account_type, inclusion: { in: %w(saving current)}
end
