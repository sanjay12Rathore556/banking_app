class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def new
    @user = User.new
    render json: {user: @user}, status: :ok 
  end

  def create
    begin
      @user = User.new(user_params)
      if @user.save
        render json: {user: @user}, status: :ok
      else
        render json: {errors: @user.errors}, status: :unprocessable_entity
      end
    rescue ActiveRecord::InvalidForeignKey => e
      render json: {error: 'Invalid Foreign Key'}, status: :unprocessable_entity
    end   
  end

  def show
    begin
      @user = User.find(params[:id])
      render json: {user: @user}, status: :ok
    rescue ActiveRecord::RecordNotFound => e 
      render json: {errors: e.message}, status: :not_found
    end
  end
  
  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
      render json: {}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end

  def index
    @users = User.all
    render json: {users:@users}, status: :ok 
  end

  def edit
    begin
      @user = User.find(params[:id])
      render json: {user:@user}, status: :ok 
    rescue ActiveRecord::RecordNotFound => e
      render json: {error:e.message}, status: :not_found
    end
  end

  def update
    begin
      @user = User.find(params[:id])
      if @user.update(user_params)
        render json: {user: @user}, status: :ok 
      else
        render json: @user.errors, status: :unprocessable_entity 
      end
    rescue => e
      render json: {error:e.message}, status: :unprocessable_entity 
    end
  end
    
	private
	def user_params
	  params.require(:user).permit(:name, :father_name, :mother_name, :address, :age, :contact_no,:branch_id)
  end
end
