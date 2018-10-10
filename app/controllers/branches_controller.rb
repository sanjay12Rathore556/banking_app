class BranchesController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def new
        @branch = Branch.new
        respond_to do |format|
            format.json { render json: {branch: @branch}, status: :ok }
        end
    end
  
    def show
        begin
            @branch = Branch.find(params[:id])
            respond_to do |format|
                format.json { render json: {branch:@branch}, status: :ok }
            end
        rescue ActiveRecord::RecordNotFound => e
            respond_to do |format|
                format.json { render json: {error:e.message}, status: :not_found}
            end
        end
    end
  
    def create
    	begin
    		@branch = Branch.new(branch_params)
            respond_to do |format|
                if @branch.save
                    format.json { render json: { branch: @branch}, status: :created }
                else
                    format.json { render json: @branch.errors, status: :unprocessable_entity }
                end
            end	
    	rescue ActiveRecord::InvalidForeignKey => e
            respond_to do |format|
                format.json { render json: {error:'Invalid Foreign Key'}, status: :unprocessable_entity }
            end
        end    
    end
  
    def destroy
        begin
            @branch = Branch.find(params[:id])
            respond_to do |format|
                @branch.destroy
                format.json { render json: {}, status: :ok }
            end  
        rescue ActiveRecord::RecordNotFound => e
            respond_to do |format|
                format.json { render json: {error:e.message}, status: :unprocessable_entity }
            end
        end
    end
  
    def index
        @branches = Branch.all
        respond_to do |format|
            format.json { render json: {branches:@branches}, status: :ok }
        end
    end
  
    def edit
        begin
            @branch = Branch.find(params[:id])
            respond_to do |format|
                format.json { render json: {branch:@branch}, status: :ok }
            end 
        rescue ActiveRecord::RecordNotFound => e
            respond_to do |format|
                format.json { render json: {error:e.message}, status: :not_found }
            end
        end
    end
  
    def update
        begin
            @branch = Branch.find(params[:id])
            respond_to do |format|
                if @branch.update(branch_params)
                    format.json { render json: {branch:@branch}, status: :ok }
                else
                    format.json { render json: @branch.errors, status: :unprocessable_entity }
                end
            end
        rescue => e
            respond_to do |format|
                format.json { render json: {error:e.message}, status: :unprocessable_entity }
            end
        end
    end
  
    private
    def branch_params
        params.require(:branch).permit(:name, :address, :contact_no,:IFSC_code,:bank_id)
    end	
end
