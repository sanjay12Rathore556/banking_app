# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  before :each do
    @bank = FactoryBot.create(:bank)
    @branch = FactoryBot.create(:branch, bank_id: @bank.id)
    @user = FactoryBot.create(:user, branch_id: @branch.id)
    @loan = FactoryBot.create(:loan, user_id: @user.id)
  end
  context 'GET#index' do
    it 'has show all loans successfully' do
      loan1 = FactoryBot.create(:loan, user_id: @user.id)
      loan2 = FactoryBot.create(:loan, user_id: @user.id)
      get :index
      expect(assigns(:loans)).to include loan1
      expect(assigns(:loans)).to include loan2
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#show' do
    it 'has get loan successfully' do
      get :show, params: { id: @loan.id }
      expect(assigns(:loan)).to eq(@loan)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get invalid loan' do
      get :show, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end
  context 'GET#new' do
    it 'has get new loan successfully' do
      get :new
      expect(assigns(:loan).id).to eq(nil)
      expect(assigns(:loan).loan_type).to eq(nil)
      expect(assigns(:loan).amount).to eq(nil)
      expect(assigns(:loan).interest).to eq(nil)
      expect(assigns(:loan).time_period).to eq(nil)
      expect(response).to have_http_status(:ok)
    end
  end
  context 'GET#edit' do
    it 'has get correct loan successfully' do
      get :edit, params: { id: @loan.id }
      expect(assigns(:loan)).to eq(@loan)
      expect(response).to have_http_status(:ok)
    end

    it 'has not get loan with invalid id' do
      get :edit, params: { id: '12345' }
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'has create loan successfully' do
      loan = FactoryBot.build(:loan, user_id: @user.id)
      loan_params = {
        loan: {
          loan_type: loan.loan_type,
          amount: loan.amount,
          interest: loan.interest,
          time_period: loan.time_period,
          user_id: loan.user_id
        }
      }
      post :create, params: loan_params
      expect(assigns(:loan).loan_type).to eq loan.loan_type
      expect(assigns(:loan).amount).to eq loan.amount
      expect(assigns(:loan).interest).to eq loan.interest
      expect(assigns(:loan).time_period).to eq loan.time_period
      expect(assigns(:loan).user_id).to eq loan.user_id
      expect(response).to have_http_status(:created)
    end

    it 'has not create loan with invalid inputs' do
      loan_params = {
        loan: {
          loan_type: nil,
          amount: nil,
          interest: nil,
          time_period: nil,
          user_id: nil
        }
      }
      post :create, params: loan_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'has update loan successfully' do
      loan1 = FactoryBot.create(:loan, user_id: @user.id)
      loan2 = FactoryBot.build(:loan, user_id: @user.id)
      put :update,
          params: {
            id: loan1.id,
            loan: {
              loan_type: loan2.loan_type,
              amount: loan2.amount,
              interest: loan2.interest,
              time_period: loan2.time_period,
              user_id: loan2.user_id
            }
          }
      expect(assigns(:loan).id).to eq loan1.id
      expect(assigns(:loan).loan_type).to eq loan2.loan_type
      expect(assigns(:loan).amount).to eq loan2.amount
      expect(assigns(:loan).interest).to eq loan2.interest
      expect(assigns(:loan).time_period).to eq loan2.time_period
      expect(assigns(:loan).user_id).to eq loan2.user_id
      expect(response).to have_http_status(:ok)
    end

    it 'has not update loan with invalid inputs' do
      loan1 = FactoryBot.create(:loan, user_id: @user.id)
      put :update, params: {
        id: loan1.id, loan: {
          loan_type: nil, amount: nil, interest: nil, time_period: nil
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has not update loan with invalid loan' do
      put :update, params: {
        id: '123456', loan: {
          loan_type: @loan.loan_type,
          amount: @loan.amount,
          interest: @loan.interest,
          time_period: @loan.time_period
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'has destroy loan successfully' do
      delete :destroy, params: { id: @loan.id }
      expect(assigns(:loan)).to eq @loan
      expect(response).to have_http_status(:ok)
    end

    it 'has not destroy invalid loan' do
      delete :destroy, params: { id: '12345' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
