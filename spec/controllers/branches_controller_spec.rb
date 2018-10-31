# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BranchesController,
               type: :controller do
  context 'GET#index' do
    it 'has show all branches successfully' do
      branch1 = FactoryBot.create(:branch)
      branch2 = FactoryBot.create(:branch)
      get :index
      expect(assigns(:branches)).to include branch1
      expect(assigns(:branches)).to include branch2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get branch successfully' do
      branch = FactoryBot.create(:branch)
      get :show, params: { id: branch.id }
      expect(assigns(:branch)).to eq(branch)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid branch' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new branch successfully' do
      get :new
      expect(assigns(:branch).id).to eq(nil)
      expect(assigns(:branch).name).to eq(nil)
      expect(assigns(:branch).address).to eq(nil)
      expect(assigns(:branch).IFSC_code).to eq(nil)
      expect(assigns(:branch).contact_no).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct branch successfully' do
      branch = FactoryBot.create(:branch)
      get :edit, params: { id: branch.id }
      expect(assigns(:branch)).to eq(branch)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get branch with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create branch successfully' do
      branch = FactoryBot.build(:branch)
      branch_params = {
        branch: {
          name: branch.name,
          address: branch.address,
          IFSC_code: branch.IFSC_code,
          contact_no: branch.contact_no,
          bank_id: branch.bank_id
        }
      }
      post :create, params: branch_params
      expect(assigns(:branch).name).to eq branch.name
      expect(assigns(:branch).address).to eq branch.address
      expect(assigns(:branch).IFSC_code).to eq branch.IFSC_code
      expect(assigns(:branch).contact_no).to eq branch.contact_no
      expect(assigns(:branch).bank_id).to eq branch.bank_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create branch with invalid inputs' do
      branch_params = {
        branch: {
          name: nil, address: nil, IFSC_code: nil, contact_no: nil, bank_id: nil
        }
      }
      post :create, params: branch_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update branch successfully' do
      branch1 = FactoryBot.create(:branch)
      branch2 = FactoryBot.build(:branch)
      put :update,
          params: {
            id: branch1.id,
            branch: {
              name: branch2.name,
              address: branch2.address,
              IFSC_code: branch2.IFSC_code,
              contact_no: branch2.contact_no,
              bank_id: branch2.bank_id
            }
          }
      expect(assigns(:branch).id).to eq branch1.id
      expect(assigns(:branch).name).to eq branch2.name
      expect(assigns(:branch).address).to eq branch2.address
      expect(assigns(:branch).IFSC_code).to eq branch2.IFSC_code
      expect(assigns(:branch).contact_no).to eq branch2.contact_no
      expect(assigns(:branch).bank_id).to eq branch2.bank_id
      expect(response).to have_http_status(:ok)
    end

    it 'has not update branch with invalid inputs' do
      branch1 = FactoryBot.create(:branch)
      put :update, params: {
        id: branch1.id, branch: {
          name: nil, address: nil, IFSC_code: nil, contact_no: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update branch with invalid branch' do
      branch = FactoryBot.create(:branch)
      put :update, params: { id: '123456', branch: {
        name: branch.name,
        address: branch.address,
        IFSC_code: branch.IFSC_code,
        contact_no: branch.contact_no
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy branch successfully' do
      branch = FactoryBot.create(:branch)
      delete :destroy, params: { id: branch.id }
      expect(assigns(:branch)).to eq branch
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid branch' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
