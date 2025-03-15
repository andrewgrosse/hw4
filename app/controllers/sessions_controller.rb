class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id  # ✅ Store user ID in session
      redirect_to places_path, notice: "Welcome, #{user.username}!"
    else
      flash[:alert] = "Invalid email or password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil  # ✅ Logout user
    redirect_to login_path, notice: "Logged out successfully."
  end
end
