# frozen_string_literal: true

# Description/Explanation of Person class
class BranchesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @branch = Branch.new
    render json: { branch: @branch }, status: :ok
  end

  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      render json: { branch: @branch }, status: :created
    else
      render json: { errors: @branch.errors }, status: :unprocessable_entity
    end
  end

  def show
    @branch = Branch.find(params[:id])
    render json: { branch: @branch }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def destroy
    @branch = Branch.find(params[:id])
    @branch.destroy
    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    @branches = Branch.all
    render json: { branchs: @branchs }, status: :ok
  end

  def edit
    @branch = Branch.find(params[:id])
    render json: { branch: @branch }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def update
    @branch = Branch.find(params[:id])
    if @branch.update(branch_params)
      render json: { branch: @branch }, status: :ok
    else
      render json: @branch.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def branch_params
    params.require(:branch).permit(
      :name, :address, :contact_no, :IFSC_code, :branch_id, :bank_id
    )
  end
end
