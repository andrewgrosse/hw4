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
      render :new
    end
  end

  def destroy
    if @entry
      @entry.destroy
      flash[:notice] = "Entry deleted successfully!"
    else
      flash[:alert] = "Entry not found or you do not have permission to delete this entry."
    end
    redirect_to place_path(@place)
  end
  
