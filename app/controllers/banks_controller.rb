class BanksController < ApplicationController
  def new
    @bank = Bank.new
  end
    
  def show
    @bank = Bank.find(params[:id])          
  end
    
  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      redirect_to @bank
    else
      render 'new'
    end          
  end
    
  def destroy
    @bank = Bank.find(params[:id])
    @bank.destroy
    redirect_to banks_path        
  end
    
  def index
    @banks = Bank.all
  end
    
  def edit
    @bank = Bank.find(params[:id])        
  end
    
  def update
    @bank = Bank.find(params[:id])
    if @bank.update(bank_params)
      redirect_to @bank
    else 
      render 'edit'          
    end
  end  
    
  private
  def bank_params
   	params.require(:bank).permit(:name,:contact_no)
  end 	
end
