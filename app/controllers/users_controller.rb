class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,   only: [:edit, :update]
  def index
    @book = Book.new
    @users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
  end

   def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated "
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user =User.find(params[:id])
    @users = @user.followers
  end

  private
def user_params
    params.require(:user).permit(:name,:email, :profile_image, :introduction)
end
def correct_user
      @user = User.find(params[:id])
      redirect_to user_path(current_user) unless @user == current_user
end

end
