class PlacesController < ApplicationController
  before_action :require_login

  def index
    @places = Place.where(user_id: session[:user_id]).order(created_at: :desc)  # Show only logged-in user's places
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = session[:user_id]

    if @place.save
      redirect_to places_path, notice: "Place added successfully!"
    else
      flash[:alert] = "Failed to add place."
      render :new
    end
  end

  def show
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])

    if @place
      @entries = Entry.where(place_id: @place.id, user_id: session[:user_id]).order(created_at: :desc) # Ensures entries always load
    else
      flash[:alert] = "You do not have access to this place."
      redirect_to places_path
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :description, :photo_url)
  end

  def require_login
    unless session[:user_id]
      flash[:alert] = "Please log in to continue."
      redirect_to login_path
    end
  end
end
