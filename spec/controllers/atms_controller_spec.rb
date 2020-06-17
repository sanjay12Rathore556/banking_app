# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AtmsController, type: :controller do
  before :each do
    @bank = FactoryBot.create(:bank)
    @atm = FactoryBot.create(:atm, bank_id: @bank.id)
  end
  context 'GET#index' do
    it 'has show all atms successfully' do
      atm1 = FactoryBot.create(:atm, bank_id: @bank.id)
      atm2 = FactoryBot.create(:atm, bank_id: @bank.id)
      get :index
      expect(assigns(:atms)).to include atm1
      expect(assigns(:atms)).to include atm2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get atm successfully' do
      get :show, params: { id: @atm.id }
      expect(assigns(:atm)).to eq(@atm)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid atm' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new atm successfully' do
      get :new
      expect(assigns(:atm).id).to eq(nil)
      expect(assigns(:atm).name).to eq(nil)
      expect(assigns(:atm).address).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct atm successfully' do
      get :edit, params: { id: @atm.id }
      expect(assigns(:atm)).to eq(@atm)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get atm with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create atm successfully' do
      atm = FactoryBot.build(:atm, bank_id: @bank.id)
      atm_params = {
        atm: {
          name: atm.name,
          address: atm.address,
          bank_id: atm.bank_id
        }
      }
      post :create, params: atm_params
      expect(assigns(:atm).name).to eq atm.name
      expect(assigns(:atm).address).to eq atm.address

      expect(assigns(:atm).bank_id).to eq atm.bank_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create atm with invalid inputs' do
      atm_params = {
        atm: {
          name: nil, address: nil, bank_id: nil
        }
      }
      post :create, params: atm_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update atm successfully' do
      atm1 = FactoryBot.create(:atm, bank_id: @bank.id)
      atm2 = FactoryBot.build(:atm, bank_id: @bank.id)
      put :update,
          params: {
            id: atm1.id,
            atm: {
              name: atm2.name,
              address: atm2.address,
              bank_id: atm2.bank_id
            }
          }
      expect(assigns(:atm).id).to eq atm1.id
      expect(assigns(:atm).name).to eq atm2.name
      expect(assigns(:atm).address).to eq atm2.address
      expect(assigns(:atm).bank_id).to eq atm2.bank_id
      expect(response).to have_http_status(:ok)
    end

    it 'has not update atm with invalid inputs' do
      atm1 = FactoryBot.create(:atm, bank_id: @bank.id)
      put :update, params: {
        id: atm1.id, atm: {
          name: nil, address: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update atm with invalid atm' do
      put :update, params: {
        id: '123456', atm: {
          name: @atm.name,
          address: @atm.address
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy atm successfully' do
      delete :destroy, params: { id: @atm.id }
      expect(assigns(:atm)).to eq @atm
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid atm' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
