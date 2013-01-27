class Venue::PlacementsController < VenueController

  def update
    @placement = Placement.find(params[:id])
    @placement.update_attributes(params[:placement])
  end

  def show
    @playlist = Playlist.find(params[:playlist_id])
    @placement = Placement.find(params[:id])
  end

  def start_playing_track
    @playlist = Playlist.find(params[:playlist_id])
    @placement = @playlist.placements.find(params[:id])
    @placement.start_playing_transition
    @placement.save!

    render nothing: true
  end

  def finish_playing_track
    @playlist = Playlist.find(params[:playlist_id])
    @placement = @playlist.placements.find(params[:id])
    @placement.stop_playing_transition
    @placement.save!
    
    @playlist.progress

    render nothing: true
  end

end