# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loan, type: :model do
  context 'loan validation' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:loan)).to be_valid
    end

    it 'does not have blank user_id' do
      expect(FactoryBot.build(:loan, user_id: '')).to be_invalid
    end
    it 'is invalid without amount' do
      expect(FactoryBot.build(:loan, amount: nil)).to be_invalid
    end
    it 'is invalid without interest' do
      expect(FactoryBot.build(:loan, interest: nil)).to be_invalid
    end
    it 'is invalid without timeperiod' do
      expect(FactoryBot.build(:loan, time_period: nil)).to be_invalid
    end
    it 'can only take amount in number' do
      expect(FactoryBot.build(:loan, amount: 'thousand')).to be_invalid
    end
    it 'can only take interest in number' do
      expect(FactoryBot.build(:loan, interest: 'two')).to be_invalid
    end
    it 'can only take timeperiod in number' do
      expect(FactoryBot.build(:loan, amount: 'two year')).to be_invalid
    end

    it 'is invalid with blank loan_type' do
      expect(FactoryBot.build(:loan, loan_type: '')).to be_invalid
    end
    it 'has valid loan_type' do
      expect(FactoryBot.build(:loan, loan_type: 'Home_Loan')).to be_valid
    end
    it 'has valid loan_type' do
      expect(FactoryBot.build(:loan, loan_type: 'Personal_Loan')).to be_valid
    end
    it 'has valid loan_type' do
      expect(FactoryBot.build(:loan, loan_type: 'Education_Loan')).to be_valid
    end
    it 'has valid loan_type' do
      expect(FactoryBot.build(:loan, loan_type: 'Business_Loan')).to be_valid
    end
    it 'has valid loan_type' do
      expect(FactoryBot.build(:loan, loan_type: 'Car_Loan')).to be_valid
    end
  end
end
