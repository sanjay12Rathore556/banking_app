# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bank, type: :model do
  context 'Bank validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:bank)).to be_valid
    end
    it 'is invalid without name' do
      expect(FactoryBot.build(:bank, name: nil)).to be_invalid
    end
    it 'is invalid without contact_no' do
      expect(FactoryBot.build(:bank, contact_no: nil)).to be_invalid
    end
    it 'is invalid with grater than 10 digit contact_no' do
      expect(
        FactoryBot.build(:bank, contact_no: '985348483949394')
      ).to be_invalid
    end

    it 'is invalid with less than 10 digit contact_no' do
      expect(FactoryBot.build(:bank, contact_no: '9853')).to be_invalid
    end
    it 'is invalid take character for contact_no' do
      expect(FactoryBot.build(:bank, contact_no: 'gbfjf12')).to be_invalid
    end
  end
end
