class ManagersController < ApplicationController
  skip_before_action :verify_authenticity_token
    
  def new
    @manager = Manager.new
    render json: {manager: @manager}, status: :ok 
  end

  def create
    begin
      @manager = Manager.new(manager_params)
      if @manager.save
        render json: {manager: @manager}, status: :ok
      else
        render json: {errors: @manager.errors}, status: :unprocessable_entity
      end
    rescue ActiveRecord::InvalidForeignKey => e
      render json: {error: 'Invalid Foreign Key'}, status: :unprocessable_entity
    end   
  end

  def show
    begin
      @manager = Manager.find(params[:id])
      render json: {manager: @manager}, status: :ok
    rescue ActiveRecord::RecordNotFound => e 
      render json: {errors: e.message}, status: :not_found
    end
  end
  
  def destroy
    begin
      @manager = Manager.find(params[:id])
      @manager.destroy
      render json: {}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end

  def index
    @managers = Manager.all
    render json: {managers:@managers}, status: :ok 
  end

  def edit
    begin
      @manager = Manager.find(params[:id])
      render json: {manager:@manager}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :not_found
    end
  end

  def update
    begin
      @manager = Manager.find(params[:id])
      if @manager.update(manager_params)
        render json: {manager: @manager}, status: :ok 
      else
        render json: @manager.errors, status: :unprocessable_entity 
      end
    rescue => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end
    
  private
  def manager_params
    params.require(:manager).permit(:name,:contact_no,:branch_id)
  end            	
end
