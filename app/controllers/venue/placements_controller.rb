class Venue::PlacementsController < VenueController

  def update
    @placement = Placement.find(params[:id])
    @placement.update_attributes(params[:placement])
  end

  def play_track
    placement = Placement.find(params[:id])
    placement.start_playing_transition
    placement.save!

    render :show
  end

  def stop_track
    placement = Placement.find(params[:id])
    placement.stop_playing_transition
    placement.save!

    render :show
  end

end