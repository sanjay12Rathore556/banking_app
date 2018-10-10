class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
	  @user = User.new
		respond_to do |format|
		  format.json { render json: {user: @user}, status: :ok }
		end
  end

	def show
		begin
			@user = User.find(params[:id])
			respond_to do |format|
				format.json { render json: {user:@user}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		begin
			@user = User.new(user_params)
		    respond_to do |format|
			    if @user.save
			     	format.json { render json: { user: @user}, status: :created }
		    	else
		    		format.json { render json: @user.errors, status: :unprocessable_entity }
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
			@user = User.find(params[:id])
			respond_to do |format|
			  @user.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@users = User.all
		respond_to do |format|
			format.json { render json: {users:@users}, status: :ok }
		end
	end

	def edit
		begin
			@user = User.find(params[:id])
			respond_to do |format|
				format.json { render json: {user:@user}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@user = User.find(params[:id])
			respond_to do |format|
				if @user.update(user_params)
					format.json { render json: {user:@user}, status: :ok }
				else
					format.json { render json: @user.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def user_params
	  params.require(:user).permit(:name, :father_name, :mother_name, :address, :age, :contact_no,:branch_id)
    end
end
