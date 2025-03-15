class EntriesController < ApplicationController
  def new
    @entry = Entry.new
    @place = Place.find(params[:place_id])  # ✅ Ensure the correct place is assigned
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = session[:user_id]

    # ✅ Ensure place_id is set correctly
    if params[:entry][:place_id].present?
      @entry.place_id = params[:entry][:place_id]
    else
      flash[:alert] = "Error: Entry must be associated with a place."
      render :new and return
    end

    if @entry.save
      redirect_to place_path(@entry.place_id), notice: "Entry added successfully!"
    else
      flash[:alert] = "Failed to add entry."
      render :new
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :place_id)
  end
end
