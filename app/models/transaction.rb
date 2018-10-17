# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :atm
  validates :transaction_type, presence: true
  validates :amount, numericality: { only_integer: true }
  validates :transaction_type, inclusion: { in: %w[withdraw deposit] }
  validate :amount_validate
  validate :amount_limit
  after_save :balance_after_withdraw
  after_save :balance_after_deposit

  private

  def amount_validate
    errors.add(:amount, 'invailid amount') if amount <= 0
  end

  def amount_limit
    if transaction_type == 'withdraw' && amount > account.balance
      errors.add(:amount, 'insufficient balance')
    end
  end

  def balance_after_withdraw
    if transaction_type == 'withdraw'
      left_balance = account.balance - amount
      account.update_attributes(balance: left_balance)
    end
  end

  def balance_after_deposit
    if transaction_type == 'deposit'
      new_balance = account.balance + amount
      account.update_attributes(balance: new_balance)
    end
  end
end
