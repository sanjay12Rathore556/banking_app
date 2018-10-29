# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'account validation' do
    it 'has a valid factory' do
      @userid = FactoryBot.create(:user)
      expect(FactoryBot.build(:account, user_id: @userid.id)).to be_valid
    end
    it 'is invalid without account_no' do
      expect(FactoryBot.build(:account, account_no: nil)).to be_invalid
    end
    it 'is invalid without user_id' do
      expect(FactoryBot.build(:account, user_id: nil)).not_to be_valid
    end

    it 'is invalid without account_type' do
      expect(FactoryBot.build(:account, account_type: nil)).not_to be_valid
    end
    it 'has valid account type' do
      @userid = FactoryBot.create(:user)
      expect(FactoryBot.build(
               :account, account_type: 'saving', user_id: @userid.id
             )).to be_valid
    end
    it 'has valid account type' do
      @userid = FactoryBot.create(:user)

      expect(
        FactoryBot.build(:account, account_type: 'current', user_id: @userid.id)
      ).to be_valid
    end
    it 'is invalid without a valid account_type' do
      expect(FactoryBot.build(:account, account_type: 'hfkghf')).not_to be_valid
    end
    it 'is invalid without valid account_no' do
      expect(
        FactoryBot.build(:account, account_no: 'hfjhg5t4434')
      ).not_to be_valid
    end
    it 'is invalid without balance' do
      expect(FactoryBot.build(:account, balance: nil)).not_to be_valid
    end
    it 'is invalid without valid balance' do
      expect(FactoryBot.build(:account, balance: '500')).not_to be_valid
    end
    it 'is invalid without valid balance' do
      expect(FactoryBot.build(:account, balance: '0')).not_to be_valid
    end
    it 'is invalid without valid balance' do
      expect(FactoryBot.build(:account, balance: '-50')).not_to be_valid
    end
  end
  context 'account associations' do
    it 'has many transactions' do
      @userid = FactoryBot.create(:user)
      @account = FactoryBot.create(:account, user_id: @userid.id)
      @t1 = FactoryBot.create(:transaction, account_id: @account.id)
      @t2 = FactoryBot.create(:transaction, account_id: @account.id)
      expect(@account.transactions).to include(@t1)
      expect(@account.transactions).to include(@t2)
    end
    it 'has not unincluded transactions' do
      @userid = FactoryBot.create(:user)
      @a1 = FactoryBot.create(:account, user_id: @userid.id)
      @a2 = FactoryBot.create(:account, user_id: @userid.id)
      @t1 = FactoryBot.create(:transaction, account_id: @a1.id)
      @t2 = FactoryBot.create(:transaction, account_id: @a2.id)
      expect(@a1.transactions).to include(@t1)
      expect(@a1.transactions).not_to include(@t2)
      expect(@a2.transactions).to include(@t2)
      expect(@a2.transactions).not_to include(@t1)
    end
    it 'is belongs to user' do
      @user = FactoryBot.create(:user)
      @a = FactoryBot.create(:account, user_id: @user.id)
      expect(@a.user.id).to eq(@user.id)
    end
    it 'is not belongs to invalid user' do
      @branch = FactoryBot.create(:branch)
      @user1 = FactoryBot.create(:user, branch_id: @branch.id)
      @user2 = FactoryBot.create(:user)

      @a = FactoryBot.create(:account, user_id: @user1.id)
      expect(@a.user.id).to eq(@user1.id)
      expect(@a.user.id).not_to eq(@user2.id)
    end
  end
end
