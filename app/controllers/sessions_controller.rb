class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id  # ✅ Stores user ID in session
      redirect_to "/places"
    else
      flash["notice"] = "Invalid email or password"
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil  # ✅ Logs user out
    flash["notice"] = "Logged out successfully."
    redirect_to "/login"
  end
end
