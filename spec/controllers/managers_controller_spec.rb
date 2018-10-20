# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManagersController,
               type: :controller do
  context 'GET#index' do
    it 'has show all managers successfully' do
      manager1 = FactoryBot.create(:manager)
      manager2 = FactoryBot.create(:manager)
      get :index
      expect(assigns(:managers)).to include manager1
      expect(assigns(:managers)).to include manager2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get manager successfully' do
      manager = FactoryBot.create(:manager)
      get :show, params: { id: manager.id }
      expect(assigns(:manager)).to eq(manager)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid manager' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new manager successfully' do
      get :new
      expect(assigns(:manager).id).to eq(nil)
      expect(assigns(:manager).name).to eq(nil)
      expect(assigns(:manager).contact_no).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct manager successfully' do
      manager = FactoryBot.create(:manager)
      get :edit, params: { id: manager.id }
      expect(assigns(:manager)).to eq(manager)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get manager with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create manager successfully' do
      manager = FactoryBot.build(:manager)
      manager_params = {
        manager: {
          name: manager.name,
          contact_no: manager.contact_no,

          branch_id: manager.branch_id
        }
      }
      post :create, params: manager_params
      expect(assigns(:manager).name).to eq manager.name
      expect(assigns(:manager).contact_no).to eq manager.contact_no

      expect(assigns(:manager).branch_id).to eq manager.branch_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create manager with invalid inputs' do
      manager_params = {
        manager: {
          name: nil, contact_no: nil, branch_id: nil
        }
      }
      post :create, params: manager_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update manager successfully' do
      manager1 = FactoryBot.create(:manager)
      manager2 = FactoryBot.build(:manager)
      put :update,
          params: {
            id: manager1.id,
            manager: {
              name: manager2.name,
              contact_no: manager2.contact_no,

              branch_id: manager2.branch_id
            }
          }
      expect(assigns(:manager).id).to eq manager1.id
      expect(assigns(:manager).name).to eq manager2.name
      expect(assigns(:manager).contact_no).to eq manager2.contact_no

      expect(response).to have_http_status(:ok)
    end

    it 'has not update manager with invalid inputs' do
      manager1 = FactoryBot.create(:manager)
      put :update, params: {
        id: manager1.id, manager: {
          name: nil, contact_no: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update manager with invalid manager' do
      manager = FactoryBot.create(:manager)
      put :update, params: {
        id: '123456', manager: {
          name: manager.name,
          contact_no: manager.contact_no
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy manager successfully' do
      manager = FactoryBot.create(:manager)
      delete :destroy, params: { id: manager.id }
      expect(assigns(:manager)).to eq manager
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid manager' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
