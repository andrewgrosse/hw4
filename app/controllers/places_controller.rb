class PlacesController < ApplicationController
  def index
    if session[:user_id]
      @places = Place.where(user_id: session[:user_id])
    else
      flash["notice"] = "Please log in to see your places."
      redirect_to "/login"
    end
  end

  def new
    @place = Place.new
  end

  def create
    if session[:user_id]
      @place = Place.new(place_params)  
      @place.user_id = session[:user_id]

      if @place.save
        redirect_to places_path
      else
        render :new
      end
    else
      flash["notice"] = "You must be logged in to create a place."
      redirect_to "/login"
    end
  end

  private  

  def place_params
    params.require(:place).permit(:name)
  end
  
end
