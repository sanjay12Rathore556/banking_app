class AtmsController < ApplicationController
  def new
    @atm = Atm.new
  end
    
  def show
    @atm = Atm.find(params[:id])          
  end
    
  def create
    @atm = Atm.new(atm_params)
    if @atm.save
      redirect_to @atm
    else
      render 'new'
    end          
  end
    
  def destroy
    @atm = Atm.find(params[:id])
    @atm.destroy
    redirect_to atms_path        
  end
    
  def index
    @atms = Atm.all
  end
    
  def edit
    @atm = Atm.find(params[:id])        
  end
    
  def update
    @atm = Atm.find(params[:id])
    if @atm.update(atm_params)
      redirect_to @atm
    else 
      render 'edit'          
    end
  end  
    
  private
  def atm_params
    params.require(:atm).permit(:name, :address,:bank_id)
  end	
end
