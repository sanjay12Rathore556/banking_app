# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @bank = FactoryBot.create(:bank)
    @branch = FactoryBot.create(:branch, bank_id: @bank.id)
    @user = FactoryBot.create(:user, branch_id: @branch.id)
  end
  context 'user validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:user, branch_id: @branch.id)).to be_valid
    end
    it 'is invalid without name ' do
      expect(FactoryBot.build(:user, name: nil, branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid without fathername ' do
      expect(FactoryBot.build(:user, father_name: nil, branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid without mothername ' do
      expect(FactoryBot.build(:user, mother_name: nil, branch_id: @branch.id)).to be_invalid
    end

    it 'is invalid without address ' do
      expect(FactoryBot.build(:user, address: nil, branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid without contact_no ' do
      expect(FactoryBot.build(:user, contact_no: nil, branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid to take character for contact_no' do
      expect(FactoryBot.build(:user, contact_no: 'jhgjf12', branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid to exceed 10 digit  contact_no' do
      expect(
        FactoryBot.build(:user, contact_no: '9898797678912', branch_id: @branch.id)
      ).to be_invalid
    end
    it 'is invalid to has less then 10 digit  contact_no' do
      expect(FactoryBot.build(:user, contact_no: '98912', branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid with age is zero ' do
      expect(FactoryBot.build(:user, age: '0', branch_id: @branch.id)).to be_invalid
    end
    it 'is invalid with age less than zero ' do
      expect(FactoryBot.build(:user, age: '-12', branch_id: @branch.id)).to be_invalid
    end
  end
end
