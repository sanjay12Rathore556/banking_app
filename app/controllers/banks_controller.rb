class BanksController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def new
    @bank = Bank.new
    render json: {bank: @bank}, status: :ok 
  end

  def create
  	begin
  	  @bank = Bank.new(bank_params)
      if @bank.save
        render json: {bank: @bank}, status: :ok
      else
        render json: {errors: @bank.errors}, status: :unprocessable_entity
      end
  	rescue ActiveRecord::InvalidForeignKey => e
  	  render json: {error: 'Invalid Foreign Key'}, status: :unprocessable_entity
  	end   
  end

  def show
    begin
      @bank = Bank.find(params[:id])
      render json: {bank: @bank}, status: :ok
    rescue ActiveRecord::RecordNotFound => e 
      render json: {errors: e.message}, status: :not_found
    end
  end
  
  def destroy
    begin
      @bank = Bank.find(params[:id])
        @bank.destroy
        render json: {}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end

  def index
    @banks = Bank.all
    render json: {banks:@banks}, status: :ok 
  end

  def edit
    begin
      @bank = Bank.find(params[:id])
      render json: {bank:@bank}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :not_found
    end
  end

  def update
    begin
      @bank = Bank.find(params[:id])
      if @bank.update(bank_params)
        render json: {bank: @bank}, status: :ok 
      else
        render json: @bank.errors, status: :unprocessable_entity 
      end
    rescue => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end
  
  private
  def bank_params
   	params.require(:bank).permit(:name,:contact_no)
  end 	
end
