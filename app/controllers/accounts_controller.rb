# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @account = Account.new
    render json: { account: @account }, status: :ok
  end

  def create
    @accont = Account.new(account_params)
    if @account.save
      render json: { account: @account }, status: :ok
    else
      render json: { errors: @account.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::InvalidForeignKey => e
    render json: { error: 'Invalid Foreign Key' }, status: :unprocessable_entity
  end

  def show
    @account = Account.find(params[:id])
    render json: { account: @account }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @accounts = Account.all
    render json: { accounts: @accounts }, status: :ok
  end

  def edit
    @account = Account.find(params[:id])
    render json: { account: @account }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      render json: { account: @account }, status: :ok
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def account_params
    params.require(:account).permit(:account_no, :balance, :account_type, :user_id)
  end
end
