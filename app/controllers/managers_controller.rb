# frozen_string_literal: true

# Description/Explanation of Person class
class ManagersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @manager = Manager.new
    respond_to do |format|
      format.html {}
      format.json { render json: { manager: @manager }, status: :ok }
    end
  end

  def create
    @manager = Manager.new(manager_params)
    if @manager.save
      render json: { manager: @manager }, status: :created
    else
      render json: { errors: @manager.errors }, status: :unprocessable_entity
    end
  end

  def show
    @manager = Manager.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { manager: @manager }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @managers = Manager.all
    render json: { managers: @managers }, status: :ok
  end

  def edit
    @manager = Manager.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render json: { manager: @manager }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @manager = Manager.find(params[:id])
    if @manager.update(manager_params)
      render json: { manager: @manager }, status: :ok
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def manager_params
    params.require(:manager).permit(:name, :contact_no, :branch_id)
  end
end
