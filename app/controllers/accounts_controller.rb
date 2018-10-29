# frozen_string_literal: true

# Description/Explanation of Person class
class AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @account = Account.new
    respond_to do |format|
      format.html{}
       format.json {render json: { account: @account }, status: :ok}
     end
  end

  def create
    @account = Account.create(account_params)
    if @account.save
      render json: { account: @account }, status: :created
    else
      render json: { errors: @account.errors }, status: :unprocessable_entity
    end
  end

  def show
    @account = Account.find(params[:id])
    respond_to do |format|
      format.html{}
       format.json {render json: { account: @account }, status: :ok}
     end
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
    respond_to do |format|
      format.html{}
       format.json {render json: { account: @account }, status: :ok}
     end
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
    params.require(:account).permit(
      :account_no, :balance, :account_type, :user_id
    )
  end
end
