class AtmsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def new
    @atm = Atm.new
    render json: {atm: @atm}, status: :ok 
  end

  def create
  	begin
  	  @atm = Atm.new(atm_params)
      if @atm.save
        render json: {atm: @atm}, status: :ok
      else
        render json: {errors: @atm.errors}, status: :unprocessable_entity
      end
  	rescue ActiveRecord::InvalidForeignKey => e
  	  render json: {error: 'Invalid Foreign Key'}, status: :unprocessable_entity
  	end   
  end

  def show
    begin
      @atm = Atm.find(params[:id])
      render json: {atm: @atm}, status: :ok
    rescue ActiveRecord::RecordNotFound => e 
      render json: {errors: e.message}, status: :not_found
    end
  end
  
  def destroy
    begin
      @atm = Atm.find(params[:id])
        @atm.destroy
        render json: {}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end

  def index
    @atms = Atm.all
    render json: {atms:@atms}, status: :ok 
  end

  def edit
    begin
      @atm = Atm.find(params[:id])
      render json: {atm:@atm}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :not_found
    end
  end

  def update
    begin
      @atm = Atm.find(params[:id])
      if @atm.update(atm_params)
        render json: {atm: @atm}, status: :ok 
      else
        render json: @atm.errors, status: :unprocessable_entity 
      end
    rescue => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end
    
  private
  def atm_params
    params.require(:atm).permit(:name, :address,:atm_id)
  end	
end
