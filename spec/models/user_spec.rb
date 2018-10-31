# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end
    it 'is invalid without name ' do
      expect(FactoryBot.build(:user, name: nil)).to be_invalid
    end
    it 'is invalid without fathername ' do
      expect(FactoryBot.build(:user, father_name: nil)).to be_invalid
    end
    it 'is invalid without mothername ' do
      expect(FactoryBot.build(:user, mother_name: nil)).to be_invalid
    end

    it 'is invalid without address ' do
      expect(FactoryBot.build(:user, address: nil)).to be_invalid
    end
    it 'is invalid without contact_no ' do
      expect(FactoryBot.build(:user, contact_no: nil)).to be_invalid
    end
    it 'is invalid to take character for contact_no' do
      expect(FactoryBot.build(:user, contact_no: 'jhgjf12')).to be_invalid
    end
    it 'is invalid to exceed 10 digit  contact_no' do
      expect(
        FactoryBot.build(:user, contact_no: '9898797678912')
      ).to be_invalid
    end
    it 'is invalid to has less then 10 digit  contact_no' do
      expect(FactoryBot.build(:user, contact_no: '98912')).to be_invalid
    end
    it 'is invalid with age is zero ' do
      expect(FactoryBot.build(:user, age: '0')).to be_invalid
    end
    it 'is invalid with age less than zero ' do
      expect(FactoryBot.build(:user, age: '-12')).to be_invalid
    end
  end
end
