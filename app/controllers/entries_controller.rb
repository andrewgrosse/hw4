class EntriesController < ApplicationController
  before_action :require_login
  before_action :set_place
  before_action :set_entry, only: [:edit, :update, :destroy]

  def index
    @entries = Entry.where(place_id: @place.id, user_id: session[:user_id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = session[:user_id]
    @entry.place_id = @place.id

    if @entry.save
      redirect_to place_entries_path(@place), notice: "Entry added successfully!"
    else
      flash[:alert] = "Failed to add entry."
      render :new
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def set_entry
    @entry = Entry.find_by(id: params[:id], user_id: session[:user_id], place_id: @place.id)
    unless @entry
      flash[:alert] = "You do not have permission to access this entry."
      redirect_to place_entries_path(@place)
    end
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image_url)
  end
end
