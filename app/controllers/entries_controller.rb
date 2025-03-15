class EntriesController < ApplicationController
  def new
    @entry = Entry.new
    @place = Place.find(params[:place_id])
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = session[:user_id]
    @entry.place_id = params[:place_id]

    if @entry.save
      redirect_to place_path(@entry.place_id), notice: "Entry added successfully!"
    else
      flash[:alert] = "Failed to add entry."
      render :new
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on)
  end
end
