class PlacesController < ApplicationController
  before_action :require_login  # ✅ Ensures user is logged in before any action

  def index
    @places = Place.where(user_id: session[:user_id])  # ✅ Only fetch places belonging to the logged-in user
  end

  def new
    @place = Place.new  # ✅ Ensures form works properly
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = session[:user_id]  # ✅ Assign place to logged-in user
  
    if @place.save
      flash[:notice] = "Place added successfully!"
      redirect_to places_path
    else
      flash[:alert] = "Failed to add place. Please try again."
      render :new  # ✅ Re-renders form if validation fails
    end
  end  

  def show
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])

    if @place
      @entries = Entry.where(place_id: @place.id)
    else
      flash[:alert] = "You do not have access to this place or it does not exist."
      redirect_to places_path
    end
  end

  def edit
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])

    unless @place
      flash[:alert] = "You do not have permission to edit this place."
      redirect_to places_path
    end
  end

  def update
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])

    if @place && @place.update(place_params)
      flash[:notice] = "Place updated successfully!"
      redirect_to places_path
    else
      flash[:alert] = "Failed to update place."
      render :edit
    end
  end

  def destroy
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])

    if @place
      @place.destroy
      flash[:notice] = "Place deleted successfully."
    else
      flash[:alert] = "You do not have permission to delete this place."
    end

    redirect_to places_path
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :description, :photo_url)  # ✅ Ensures only allowed fields are submitted
  end

  def require_login
    unless session[:user_id]
      flash[:alert] = "You must be logged in to access this page."
      redirect_to "/login"
    end
  end
end
