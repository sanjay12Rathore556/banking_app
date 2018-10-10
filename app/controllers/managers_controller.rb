class ManagersController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@manager = Manager.new
		respond_to do |format|
			format.json {render json:{manager: @manager},status: :ok}
	    end	
	end

	def show
		begin
		    @manager = Manager.find(params[:id])
	        respond_to do |format|
	            format.json {render json:{manager:@manager},status: :ok} 
	        end   		
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json {render json:{error:e.massage},status: :not_found}
			end
		end
	end
		
	def create
		begin
			@manager = Manager.new(manager_params)
	        respond_to do |format|
	    	    if @manager.save
	    		    format.json{render json: {manager:@manager},status: :created}
	         	else
	    	     	format.json{render json: @manager.errors , status: :unprocessable_entity}
	   	        end
	        end    	
		rescue ActiveRecord::InvalidForeignKey => e
            respond_to do |format|
                format.json { render json: {error:'Invalid Foreign Key'}, status: :unprocessable_entity }
            end
        end       
	end

    def update
    	begin
    		@manager = Manager.find(params[:id])
    		respond_to do |format|
    			if @manager.update(manager_params) 
    				format.json {render json:{manager: @manager},status: :ok}
    			else
    				format.json {render json: @manager.errors,status: :unprocessable_entity}
    		    end	
    		end   	
    	rescue => e
    		respond_to do |format|
    	        format.json{render json: {error:e.massage},status: :unprocessable_entity}
    	    end	
        end    
    end

    def edit
    	begin
    		@manager = Manager.find(params[:id])
    		respond_to do |format|
    			format.json {render json:{manager:@manager},status: :ok}
    		end	
    	rescue ActiveRecord::RecordNotFound => e
    		respond_to do |format|
    			format.json { render json: {error:e.message},status: :not_found}
    		end
    	end
    end
    
    def index
        @managers = Manager.all
        respond_to do |format|
            format.json {render json:{manager:@managers},status: :ok}
        end
    end

    def destroy
		begin
			@manager = Manager.find(params[:id])
			respond_to do |format|
			    @manager.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

    private
    def manager_params
        params.require(:manager).permit(:name,:contact_no,:branch_id)
    end            	
end
