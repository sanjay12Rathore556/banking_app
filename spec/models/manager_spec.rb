# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Manager, type: :model do
  context 'manager validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:manager)).to be_valid
    end
    it 'is invalid without name' do
      expect(FactoryBot.build(:manager, name: nil)).to be_invalid
    end
    it 'is invalid without branch' do
      expect(FactoryBot.build(:manager, branch_id: nil)).to be_invalid
    end
    it 'is invalid without contact_no' do
      expect(FactoryBot.build(:manager, contact_no: nil)).to be_invalid
    end
    it 'is invalid to take character for contact_no' do
      expect(FactoryBot.build(:manager, contact_no: 'jhgjf12')).to be_invalid
    end
    it 'is invalid to exceed 10 digit  contact_no' do
      expect(FactoryBot.build(:manager, contact_no: '98984545678912')).to be_invalid
    end
    it 'is invalid to has less then 10 digit  contact_no' do
      expect(FactoryBot.build(:manager, contact_no: '98912')).to be_invalid
    end
  end
end
