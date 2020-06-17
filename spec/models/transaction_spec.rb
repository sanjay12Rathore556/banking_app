# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before :each do
    @bank = FactoryBot.create(:bank)
    @atm = FactoryBot.create(:atm, bank_id: @bank.id)
    @branch = FactoryBot.create(:branch, bank_id: @bank.id)
    @user = FactoryBot.create(:user, branch_id: @branch.id)
    @account = FactoryBot.create(:account, user_id: @user.id)
    @transaction = FactoryBot.build(:transaction, account_id: @account.id)
  end
  context 'Transaction validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:transaction, account_id: @account.id, atm_id: @atm.id)).to be_valid
    end
    it 'is invalid without a atm' do
      expect(FactoryBot.build(:transaction, account_id: @account.id, atm_id: nil)).to be_invalid
    end
    it 'is invalid without a account' do
      expect(FactoryBot.build(:transaction, atm_id: @atm.id, account_id: nil)).to be_invalid
    end
    it 'is invalid without transaction type' do
      expect(
        FactoryBot.build(:transaction, account_id: @account.id, atm_id: @atm.id, transaction_type: nil)
      ).to be_invalid
    end
    it 'is invalid to has zero amount' do
      expect(FactoryBot.build(:transaction, amount: '0', account_id: @account.id, atm_id: @atm.id)).to be_invalid
    end
    it 'is invalid to has less then zero amount' do
      expect(FactoryBot.build(:transaction, amount: '-12', account_id: @account.id, atm_id: @atm.id)).to be_invalid
    end
    it 'is invalid without valid condition' do
      @a = FactoryBot.create(:account, balance: '2000', user_id: @user.id)
      @t = FactoryBot.build(
        :transaction,
        transaction_type: 'withdraw',
        amount: '4000',
        atm_id: @atm.id,
        account_id: @a.id
      )
      expect(@t).to be_invalid
    end
    it 'is update balance after withdraw' do
      @a = FactoryBot.create(:account, balance: '2000', user_id: @user.id)
      @t = FactoryBot.create(
        :transaction,
        transaction_type: 'withdraw',
        amount: '500',
        atm_id: @atm.id,
        account_id: @a.id
      )
      @left = @a.balance - @t.amount
      expect(@t.account.balance).to eq(@left)
    end
    it 'is update balance after deposit ' do
      @a = FactoryBot.create(:account, balance: '2000', user_id: @user.id)
      @t = FactoryBot.create(
        :transaction,
        transaction_type: 'deposit',
        amount: '500',
        atm_id: @atm.id,
        account_id: @a.id
      )
      @left = @a.balance + @t.amount
      expect(@t.account.balance).to eq(@left)
    end
  end
end
