class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])  # ✅ Uses Bcrypt for authentication
      session[:user_id] = @user.id
      redirect_to places_path, notice: "Logged in successfully!"
    else
      flash[:alert] = "Invalid email or password."
      redirect_to login_path
    end
  end

  def destroy
    Rails.logger.debug "🔥 SessionsController#destroy was called"
    Rails.logger.debug "Current session: #{session.to_h}"
  
    session[:user_id] = nil  # ✅ Logs out user
    reset_session            # ✅ Completely clears session
    
    Rails.logger.debug "After logout, session: #{session.to_h}"
  
    redirect_to login_path, notice: "Logged out successfully!"
  end
  
end
