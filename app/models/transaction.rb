# frozen_string_literal: true

# Description/Explanation of Person class
class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :atm
  validates :transaction_type, :account_id, :atm_id, presence: true
  validates :amount, numericality: { only_integer: true }
  validates :transaction_type, inclusion: { in: %w[withdraw deposit] }
  validate :amount_validate
  validate :amount_limit
  after_save :balance_after_withdraw
  after_save :balance_after_deposit

  private

  def amount_validate
    errors.add(:amount, 'invailid amount') if amount.nil? || amount <= 0
  end

  def amount_limit
    errors.add(:amount, 'insufficient balance') if
    transaction_type == 'withdraw' && (account && amount > account.balance)
  end

  def balance_after_withdraw
    left_balance = account.balance - amount
    account.update_attributes(balance: left_balance) if
    transaction_type == 'withdraw'
  end

  def balance_after_deposit
    new_balance = account.balance + amount
    account.update_attributes(balance: new_balance) if
    transaction_type == 'deposit'
  end
end
