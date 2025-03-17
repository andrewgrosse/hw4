class EntriesController < ApplicationController
  before_action :require_login
  before_action :set_place
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = Entry.where(place_id: @place.id, user_id: session[:user_id]).order(created_at: :desc)
  end

  def show
    # ✅ This action allows users to view a single entry
  end

  def new
    @entry = @place.entries.new
  end

  def create
    @entry = @place.entries.new(entry_params)
    @entry.user_id = session[:user_id]

    if @entry.save
      redirect_to place_path(@place), notice: "Entry added successfully!"
    else
      flash[:alert] = "Failed to add entry."
      render :new
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to place_path(@place), notice: "Entry updated successfully!"
    else
      flash[:alert] = "Failed to update entry."
      render :edit
    end
  end

  def destroy
    if @entry
      @entry.destroy
      flash[:notice] = "Entry deleted successfully!"
    else
      flash[:alert] = "Entry not found."
    end
    redirect_to place_path(@place)
  end

  private

  def set_place
    @place = Place.find_by(id: params[:place_id])
    unless @place
      flash[:alert] = "Place not found."
      redirect_to places_path
    end
  end

  def set_entry
    @entry = Entry.find_by(id: params[:id], place_id: @place.id, user_id: session[:user_id])
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image_url)
  end
end
