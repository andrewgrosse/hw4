class PlacesController < ApplicationController
  def index
    if session[:user_id]
      @places = Place.where(user_id: session[:user_id])
    else
      flash["notice"] = "Please log in to see your places."
      redirect_to "/login"
    end
  end

  def show
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])

    if @place
      @entries = Entry.where(place_id: @place.id)
    else
      flash["notice"] = "You do not have access to this place or it does not exist."
      redirect_to "/places"
    end
  end
end
