# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Branch, type: :model do
  before :each do
    @bank = FactoryBot.create(:bank)
    @branch = FactoryBot.create(:branch, bank_id: @bank.id)
  end
  context 'model validations' do
    it 'is a valid factory' do
      branch = FactoryBot.build(:branch, bank_id: @bank.id)
      expect(branch).to be_valid
    end
    it 'is invalid to has  address nil' do
      expect(FactoryBot.build(:branch, address: nil, bank_id: @bank.id)).to be_invalid
    end
    it 'is invalid to has ifsc_code nil' do
      expect(FactoryBot.build(:branch, IFSC_code: nil, bank_id: @bank.id)).to be_invalid
    end
    it 'is invalid to has contact_no nil' do
      expect(FactoryBot.build(:branch, contact_no: nil, bank_id: @bank.id)).to be_invalid
    end
    it 'is invalid without bank' do
      expect(FactoryBot.build(:branch, bank_id: nil)).to be_invalid
    end
    it 'is invalid to take character for contact_no' do
      expect(FactoryBot.build(:branch, contact_no: 'jhgjf12', bank_id: @bank.id)).to be_invalid
    end
    it 'is invalid to exceed 10 digit  contact_no' do
      expect(
        FactoryBot.build(:branch, contact_no: '98984545678912', bank_id: @bank.id)
      ).to be_invalid
    end
    it 'is invalid to has less then 10 digit  contact_no' do
      expect(FactoryBot.build(:branch, contact_no: '98912', bank_id: @bank.id)).to be_invalid
    end
  end
end
