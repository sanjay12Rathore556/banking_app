# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'Transaction validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:transaction)).to be_valid
    end
    it 'is invalid without a atm' do
      expect(FactoryBot.build(:transaction, atm_id: nil)).to be_invalid
    end
    it 'is invalid without a account' do
      expect(FactoryBot.build(:transaction, account_id: nil)).to be_invalid
    end
    it 'is invalid without transaction type' do
      expect(FactoryBot.build(:transaction, transaction_type: nil)).to be_invalid
    end
    it 'is invalid to has zero amount' do
      expect(FactoryBot.build(:transaction, amount: '0')).to be_invalid
    end
    it 'is invalid to has less then zero amount' do
      expect(FactoryBot.build(:transaction, amount: '-12')).to be_invalid
    end
    it 'has valid transaction_type' do
      expect(FactoryBot.build(:transaction, transaction_type: 'withdraw')).to be_valid
    end
    it 'has valid transaction_type' do
      expect(FactoryBot.build(:transaction, transaction_type: 'deposit')).to be_valid
    end
    it 'is invalid without valid condition' do
      @a = FactoryBot.create(:account, balance: '2000')
      @t = FactoryBot.build(:transaction, transaction_type: 'withdraw', amount: '4000', account_id: @a.id)
      expect(@t).to be_invalid
    end
    it 'is update balance after withdraw' do
      @a = FactoryBot.create(:account, balance: '2000')
      @t = FactoryBot.create(:transaction, transaction_type: 'withdraw', amount: '500', account_id: @a.id)
      @left = @a.balance - @t.amount
      expect(@t.account.balance).to eq(@left)
    end
    it 'is update balance after deposit ' do
      @a = FactoryBot.create(:account, balance: '2000')
      @t = FactoryBot.create(:transaction, transaction_type: 'deposit', amount: '500', account_id: @a.id)
      @left = @a.balance + @t.amount
      expect(@t.account.balance).to eq(@left)
    end
  end
end
