class Venue::PlaylistsController < VenueController
  def show
    @playlist = Playlist.find(params[:id])
    @upcoming_placements = @playlist.up_next
  end
end