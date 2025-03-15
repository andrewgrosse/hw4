class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id  # ✅ Log in user after signup
      redirect_to places_path, notice: "Welcome, #{@user.username}!"
    else
      flash[:alert] = "Signup failed. Please try again."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
