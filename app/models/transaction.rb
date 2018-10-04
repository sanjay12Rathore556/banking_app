class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :atm
  validates :transaction_type,presence: true
  validates :amount,numericality: {only_integer: true}
  validates :transaction_type,inclusion: { in: %w(withdraw deposit)}
  validate :amount_validate
  validate :amount_limit
  after_save :balance_update
  private
    def amount_validate
      if self.amount <= 0
      	errors.add(:amount,"invailid amount")
      end
    end  	
    def amount_limit
      if self.transaction_type == 'withdraw' && self.amount > self.account.balance
        errors.add(:amount,"insufficient balance")
      end
    end    	
    def balance_update
      if self.transaction_type == "withdraw"
        left_balance = self.account.balance-self.amount
        self.account.update_attributes(balance: left_balance)  
      elsif self.transaction_type == 'deposit'
        new_balance = self.account.balance+self.amount
        self.account.update_attributes(balance: new_balance)
      end  
    end  	
end
