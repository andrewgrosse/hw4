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
  
  def show
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])
  
    if @place
      @entries = Entry.where(place_id: @place.id)
    else
      flash["notice"] = "You do not have access to this place."
      redirect_to "/places"
    end
  end  

  def show
    puts "DEBUG: params[:id] = #{params[:id]}"
    puts "DEBUG: session[:user_id] = #{session[:user_id]}"
  
    @place = Place.find_by(id: params[:id], user_id: session[:user_id])
  
    puts "DEBUG: @place = #{@place.inspect}"  # ✅ Check what Rails finds
  
    if @place
      @entries = Entry.where(place_id: @place.id)
    else
      flash["notice"] = "You do not have access to this place or it does not exist."
      redirect_to "/places"
    end
  end
  

end
