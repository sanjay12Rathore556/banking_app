class BranchesController < ApplicationController
  def new
    @branch = Branch.new
  end
    
  def show
    @branch = Branch.find(params[:id])          
  end
    
  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      redirect_to @branch
    else
      render 'new'
    end          
  end
    
  def destroy
    @branch = Branch.find(params[:id])
    @branch.destroy
    redirect_to branches_path        
  end
    
  def index
    @branches = Branch.all
  end
    
  def edit
    @branch = Branch.find(params[:id])        
  end
    
  def update
    @branch = Branch.find(params[:id])
    if @branch.update(branch_params)
      redirect_to @branch
    else 
      render 'edit'          
    end
  end  
    
  private
  def branch_params
    params.require(:branch).permit(:name, :address, :contact_no,:IFSC_code,:bank_id)
  end	
end
