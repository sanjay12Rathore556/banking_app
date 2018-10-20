# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController,
               type: :controller do
  context 'GET#index' do
    it 'has show all transactions successfully' do
      transaction1 = FactoryBot.create(:transaction)
      transaction2 = FactoryBot.create(:transaction)
      get :index
      expect(assigns(:transactions)).to include transaction1
      expect(assigns(:transactions)).to include transaction2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get transaction successfully' do
      transaction = FactoryBot.create(:transaction)
      get :show, params: { id: transaction.id }
      expect(assigns(:transaction)).to eq(transaction)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid transaction' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new transaction successfully' do
      get :new
      expect(assigns(:transaction).id).to eq(nil)
      expect(assigns(:transaction).amount).to eq(nil)
      expect(assigns(:transaction).transaction_type).to eq(nil)
      expect(assigns(:transaction).atm_id).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct transaction successfully' do
      transaction = FactoryBot.create(:transaction)
      get :edit, params: { id: transaction.id }
      expect(assigns(:transaction)).to eq(transaction)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get transaction with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create transaction successfully' do
      transaction = FactoryBot.build(:transaction)
      transaction_params = {
        transaction: {
          amount: transaction.amount,
          transaction_type: transaction.transaction_type,
          atm_id: transaction.atm_id,
          account_id: transaction.account_id
        }
      }
      post :create, params: transaction_params
      expect(assigns(:transaction).amount).to eq transaction.amount
      expect(
        assigns(:transaction).transaction_type
      ).to eq transaction.transaction_type
      expect(assigns(:transaction).atm_id).to eq transaction.atm_id
      expect(assigns(:transaction).account_id).to eq transaction.account_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create transaction with invalid inputs' do
      transaction_params = {
        transaction: {
          amount: nil, transaction_type: nil, atm_id: nil, account_id: nil
        }
      }
      post :create, params: transaction_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update transaction successfully' do
      @b = FactoryBot.create(:branch, IFSC_code: 'etugght34')
      @u = FactoryBot.create(:user, branch_id: @b.id)
      transaction1 = FactoryBot.create(:transaction)
      transaction2 = FactoryBot.build(:transaction)
      put :update,
          params: {
            id: transaction1.id,
            transaction: {
              amount: transaction2.amount,
              transaction_type: transaction2.transaction_type,
              atm_id: transaction2.atm_id,
              account_id: transaction2.account_id
            }
          }
      expect(assigns(:transaction).id).to eq transaction1.id
      expect(assigns(:transaction).amount).to eq transaction2.amount
      expect(
        assigns(:transaction).transaction_type
      ).to eq transaction2.transaction_type
      expect(assigns(:transaction).atm_id).to eq transaction2.atm_id
      expect(assigns(:transaction).account_id).to eq transaction2.account_id
      expect(response).to have_http_status(:ok)
    end

    it 'has not update transaction with invalid inputs' do
      transaction1 = FactoryBot.create(:transaction)
      put :update, params: {
        id: transaction1.id, transaction: {
          amount: nil, transaction_type: nil, atm_id: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update transaction with invalid transaction' do
      transaction = FactoryBot.create(:transaction)
      put :update, params: { id: '123456', transaction: {
        amount: transaction.amount,
        transaction_type: transaction.transaction_type,
        atm_id: transaction.atm_id
      } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy transaction successfully' do
      transaction = FactoryBot.create(:transaction)
      delete :destroy, params: { id: transaction.id }
      expect(assigns(:transaction)).to eq transaction
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid transaction' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
