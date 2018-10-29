# frozen_string_literal: true

# Description/Explanation of Person class
class AtmsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @atm = Atm.new
    respond_to do |format|
      format.html{}
       format.json {render json: { atm: @atm }, status: :ok}
     end
  end

  def create
    @atm = Atm.new(atm_params)
    if @atm.save
      render json: { atm: @atm }, status: :created
    else
      render json: { errors: @atm.errors }, status: :unprocessable_entity
    end
  end

  def show
    @atm = Atm.find(params[:id])
    respond_to do |format|
      format.html{}
       format.json {render json: { atm: @atm }, status: :ok}
     end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @atm = Atm.find(params[:id])
    @atm.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @atms = Atm.all
    render json: { atms: @atms }, status: :ok
  end

  def edit
    @atm = Atm.find(params[:id])
    respond_to do |format|
      format.html{}
       format.json {render json: { atm: @atm }, status: :ok}
     end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @atm = Atm.find(params[:id])
    if @atm.update(atm_params)
      
      render json: { atm: @atm }, status: :ok
     
    else
      render json: @atm.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def atm_params
    params.require(:atm).permit(:name, :address, :bank_id)
  end
end
