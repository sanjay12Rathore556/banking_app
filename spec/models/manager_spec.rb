# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Manager, type: :model do
  before :each do
    @bank = FactoryBot.create(:bank)
    @branch = FactoryBot.create(:branch, bank_id: @bank.id)
    @manager = FactoryBot.create(:manager, branch_id: @branch.id)
  end
  context 'manager validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:manager, branch_id: @branch.id)).to be_valid
    end
    it 'is invalid without name' do
      expect(FactoryBot.build(:manager, name: nil, branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid without branch' do
      expect(FactoryBot.build(:manager, branch_id: nil)).to be_invalid
    end
    it 'is invalid without contact_no' do
      expect(FactoryBot.build(:manager, contact_no: nil, branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid to take character for contact_no' do
      expect(FactoryBot.build(:manager, contact_no: 'jhgjf12', branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid to exceed 10 digit  contact_no' do
      expect(
        FactoryBot.build(:manager, contact_no: '98984545678912', branch_id: @branch.id)
      ).to be_invalid
    end
    it 'is invalid to has less then 10 digit  contact_no' do
      expect(
        FactoryBot.build(:manager, contact_no: '98912', branch_id: @branch.id)
      ).to be_invalid
    end
  end
end
