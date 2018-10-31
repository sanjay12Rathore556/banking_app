# frozen_string_literal: true

# Description/Explanation of Person class
class LoansController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @loan = Loan.new
    render json: { loan: @loan }, status: :ok
  end

  def create
    @loan = Loan.new(loan_params)
    if @loan.save
      render json: { loan: @loan }, status: :created
    else
      render json: { errors: @loan.errors }, status: :unprocessable_entity
    end
  end

  def show
    @loan = Loan.find(params[:id])
    render json: { loan: @loan }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @loans = Loan.all
    render json: { loans: @loans }, status: :ok
  end

  def edit
    @loan = Loan.find(params[:id])
    render json: { loan: @loan }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @loan = Loan.find(params[:id])
    if @loan.update(loan_params)
      render json: { loan: @loan }, status: :ok
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def loan_params
    params.require(:loan).permit(:loan_type, :amount, :interest,
                                 :time_period, :branch_id, :user_id)
  end
end
