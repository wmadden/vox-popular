class Venue::PlacementsController < VenueController

  def update
    @placement = Placement.find(params[:id])
    @placement.update_attributes(params[:placement])
  end

  def start_playing_track
    placement = Placement.find(params[:id])
    placement.start_playing_transition
    placement.save!

    render :show
  end

  def finish_playing_track
    placement = Placement.find(params[:id])
    placement.stop_playing_transition
    placement.save!

    render :show
  end

end