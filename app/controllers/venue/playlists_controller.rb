class Venue::PlaylistsController < VenueController
  def show
    @playlist = Playlist.find(params[:id])
  end
end