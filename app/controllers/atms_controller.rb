class AtmsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def new
        @atm = Atm.new
        respond_to do |format|
            format.json { render json: {atm: @atm}, status: :ok }
        end
    end
    
    def show
        begin
            @atm = Atm.find(params[:id])
            respond_to do |format|
                format.json { render json: {atm:@atm}, status: :ok }
            end
        rescue ActiveRecord::RecordNotFound => e
            respond_to do |format|
                format.json { render json: {error:e.message}, status: :not_found}
            end
        end
    end
    
    def create
    	begin
    		@atm = Atm.new(atm_params)
            respond_to do |format|
                if @atm.save
                    format.json { render json: { atm: @atm}, status: :created }
                else
                    format.json { render json: @atm.errors, status: :unprocessable_entity }
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
            @atm = Atm.find(params[:id])
            respond_to do |format|
                @atm.destroy
                format.json { render json: {}, status: :ok }
            end
        rescue ActiveRecord::RecordNotFound => e
            respond_to do |format|
                format.json { render json: {error:e.message}, status: :unprocessable_entity }
            end
        end
    end
    
    def index
        @atms = Atm.all
        respond_to do |format|
            format.json { render json: {atms:@atms}, status: :ok }
        end
    end
    
    def edit
        begin
            @atm = Atm.find(params[:id])
            respond_to do |format|
                format.json { render json: {atm:@atm}, status: :ok }
            end
        rescue ActiveRecord::RecordNotFound => e
            respond_to do |format|
                format.json { render json: {error:e.message}, status: :not_found }
            end
        end
    end
    
    def update
        begin
            @atm = Atm.find(params[:id])
            respond_to do |format|
                if @atm.update(Atm_params)
                    format.json { render json: {atm:@atm}, status: :ok }
                else
                    format.json { render json: @atm.errors, status: :unprocessable_entity }
                end
            end
        rescue => e
            respond_to do |format|
                format.json { render json: {error:e.message}, status: :unprocessable_entity }
            end
        end
    end
    
    private
    def atm_params
        params.require(:Atm).permit(:name, :address,:bank_id)
    end	
end
