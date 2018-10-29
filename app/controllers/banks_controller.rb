# frozen_string_literal: true

# Description/Explanation of Person class
class BanksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @bank = Bank.new
    respond_to do |format|
      format.html {}
      format.json { render json: { bank: @bank }, status: :ok }
    end
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      render json: { bank: @bank }, status: :created
    else
      render json: { errors: @bank.errors }, status: :unprocessable_entity
    end
  end

  def show
    @bank = Bank.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { bank: @bank }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @bank = Bank.find(params[:id])
    @bank.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @banks = Bank.all
    respond_to do |format|
      format.html {}
      format.json { render json: { banks: @banks }, status: :ok }
    end
  end

  def edit
    @bank = Bank.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { bank: @bank }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @bank = Bank.find(params[:id])
    if @bank.update(bank_params)

      render json: { bank: @bank }, status: :ok

    else
      render json: @bank.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def bank_params
    params.require(:bank).permit(:name, :contact_no)
  end
end
