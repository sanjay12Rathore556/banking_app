class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def new
    @transaction = Transaction.new
    render json: {transaction: @transaction}, status: :ok 
  end

  def create
    begin
      @transaction = Transaction.new(transaction_params)
      if @transaction.save
        render json: {transaction: @transaction}, status: :ok
      else
        render json: {errors: @transaction.errors}, status: :unprocessable_entity
      end
    rescue ActiveRecord::InvalidForeignKey => e
      render json: {error: 'Invalid Foreign Key'}, status: :unprocessable_entity
    end   
  end

  def show
    begin
      @transaction = Transaction.find(params[:id])
      render json: {transaction: @transaction}, status: :ok
    rescue ActiveRecord::RecordNotFound => e 
      render json: {errors: e.message}, status: :not_found
    end
  end
  
  def destroy
    begin
      @transaction = Transaction.find(params[:id])
      @transaction.destroy
      render json: {}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end

  def index
    @transactions = Transaction.all
    render json: {transactions:@transactions}, status: :ok 
  end

  def edit
    begin
      @transaction = Transaction.find(params[:id])
      render json: {transaction:@transaction}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :not_found
    end
  end

  def update
    begin
      @transaction = Transaction.find(params[:id])
      if @transaction.update(transaction_params)
        render json: {transaction: @transaction}, status: :ok 
      else
        render json: @transaction.errors, status: :unprocessable_entity 
      end
    rescue => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end
    
  private
  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :transaction_id,:account_id)
  end	
end
