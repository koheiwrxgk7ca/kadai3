class UsersController < ApplicationController
  def show
    @book1 = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @user = current_user
    @book1 = Book.new
    @users = User.all
  end

  def edit
    user_id = params[:id].to_i
    login_user_id = current_user.id
   if(user_id != login_user_id)
    redirect_to user_path(current_user.id)
   end
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
   if @user.update(user_params)
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user.id)
   else
     render :edit
   end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
