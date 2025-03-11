require 'digest' #hashing passwords manually

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    #check if user exists and password is correct
    if user && user["password"] ==Digest::SHA256.hexigest(params[:password])
      session[:user_id] = user.id
      redirect_to "/places"
    else
      flash["notice"] = "Invalid email or password"
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/login"
  end
end
  