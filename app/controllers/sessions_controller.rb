class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])  # Bcrypt authenticates password
      session[:user_id] = user.id
      redirect_to "/places"
    else
      flash["notice"] = "Invalid email or password"
      redirect_to "/login"
    end
  end


