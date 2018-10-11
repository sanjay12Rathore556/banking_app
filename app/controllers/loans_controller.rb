class LoansController < ApplicationController
  def new
    @loan = Loan.new
  end
    
  def show
    @loan = Loan.find(params[:id])          
  end
    
  def create
    @loan = Loan.new(loan_params)
    if @loan.save
      redirect_to @loan
    else
      render 'new'
    end          
  end
    
  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy
    redirect_to loans_path        
  end
    
  def index
    @loans = Loan.all
  end
    
  def edit
    @loan = Loan.find(params[:id])        
  end
    
  def update
    @loan = Loan.find(params[:id])
    if @loan.update(loan_params)
      redirect_to @loan
    else 
      render 'edit'          
    end
  end  
    
  private
  def loan_params
    params.require(:loan).permit(:loan_type, :amount, :interest,:time_period,:branch_id,:user_id)
  end	
end
