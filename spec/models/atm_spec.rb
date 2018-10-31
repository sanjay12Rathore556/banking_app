# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Atm, type: :model do
  context 'atm validation' do
    it 'has valid factory' do
      expect(FactoryBot.create(:atm)).to be_valid
    end
    it 'is invalid without a name' do
      expect(FactoryBot.build(:atm, name: nil)).not_to be_valid
    end
    it 'is invalid without address' do
      expect(FactoryBot.build(:atm, address: nil)).not_to be_valid
    end
    it 'is invalid without bank' do
      expect(FactoryBot.build(:atm, bank_id: nil)).to be_invalid
    end
  end
  context 'atm associations' do
    it 'has many transactions' do
      @b = FactoryBot.create(:branch, IFSC_code: 'GGDGF34')
      @u = FactoryBot.create(:user, branch_id: @b.id)
      @a = FactoryBot.create(:account, user_id: @u.id)
      @atm = FactoryBot.create(:atm)
      @t = FactoryBot.create(:transaction, account_id: @a.id, atm_id: @atm.id)
      @t2 = FactoryBot.create(:transaction, account_id: @a.id, atm_id: @atm.id)
      expect(@atm.transactions).to include(@t)
      expect(@atm.transactions).to include(@t2)
    end
    it 'has not unincluded tarnsactions' do
      @b = FactoryBot.create(:branch, IFSC_code: 'GGDGF34')
      @u = FactoryBot.create(:user, branch_id: @b.id)
      @a = FactoryBot.create(:account, user_id: @u.id)
      @atm1 = FactoryBot.create(:atm)
      @atm2 = FactoryBot.create(:atm)
      @t1 = FactoryBot.create(:transaction, account_id: @a.id, atm_id: @atm1.id)
      @t2 = FactoryBot.create(:transaction, account_id: @a.id, atm_id: @atm2.id)
      expect(@atm1.transactions).to include(@t1)
      expect(@atm1.transactions).not_to include(@t2)
      expect(@atm2.transactions).to include(@t2)
      expect(@atm2.transactions).not_to include(@t1)
    end
    it 'has belongs to bank' do
      @b = FactoryBot.create(:bank)
      @a = FactoryBot.create(:atm, bank_id: @b.id)
      expect(@a.bank.id).to eq(@b.id)
    end
    it 'is not belongs to invalid bank' do
      @b1 = FactoryBot.create(:bank)
      @b2 = FactoryBot.create(:bank)
      @a1 = FactoryBot.create(:atm, bank_id: @b1.id)
      expect(@a1.bank.id).to eq(@b1.id)
      expect(@a1.bank.id).not_to eq(@b2.id)
    end
  end
end
