class PlacesController < ApplicationController

  def index
      if session[:user_id]
        @places = Place.where({"user_id" => session[:user_id]}) # Only show logged-in user's places
      else
        @places = []
        flash["notice"] = "Please log in to see your places."
        redirect_to "/login"
      end
  end

  def show
    @place = Place.find_by({ "id" => params["id"], "user_id" => session[:user_id] })
    if @place
      @entries = Entry.where({ "place_id" => @place["id"] })
    else
      flash["notice"] = "You do not have access to this place."
      redirect_to "/places"
    end
  end

  def new
    if session[:user_id].nil?
      flash["notice"] = "Please log in to add a place."
      redirect_to "/login"
    end
  end

  def create
    if session[:user_id]
      @place = Place.new
      @place["name"] = params["name"]
      @place["user_id"] = session[:user_id]  # Assign place to logged-in user
      if @place.save
        redirect_to "/places"
      else
        render :new
      end
    else
      flash["notice"] = "You must be logged in to create a place."
      redirect_to "/login"
    end
  end
end
