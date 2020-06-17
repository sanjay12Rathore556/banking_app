# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loan, type: :model do
  before :each do
    @bank = FactoryBot.create(:bank)
    @branch = FactoryBot.create(:branch, bank_id: @bank.id)
    @user = FactoryBot.create(:user, branch_id: @branch.id)
    @loan = FactoryBot.create(:loan, user_id: @user.id)
  end
  context 'loan validation' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:loan, user_id: @user.id)).to be_valid
    end

    it 'does not have blank user_id' do
      expect(FactoryBot.build(:loan, user_id: '')).to be_invalid
    end
    it 'is invalid without amount' do
      expect(FactoryBot.build(:loan, amount: nil, user_id: @user.id)).to be_invalid
    end
    it 'is invalid without interest' do
      expect(FactoryBot.build(:loan, interest: nil, user_id: @user.id)).to be_invalid
    end
    it 'is invalid without timeperiod' do
      expect(FactoryBot.build(:loan, time_period: nil, user_id: @user.id)).to be_invalid
    end
    it 'can only take amount in number' do
      expect(FactoryBot.build(:loan, amount: 'thousand', user_id: @user.id)).to be_invalid
    end
    it 'can only take interest in number' do
      expect(FactoryBot.build(:loan, interest: 'two', user_id: @user.id)).to be_invalid
    end
    it 'can only take timeperiod in number' do
      expect(FactoryBot.build(:loan, amount: 'two year', user_id: @user.id)).to be_invalid
    end

    it 'is invalid with blank loan_type' do
      expect(FactoryBot.build(:loan, loan_type: '', user_id: @user.id)).to be_invalid
    end
  end
end
