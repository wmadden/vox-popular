class Venue::PlaylistsController < VenueController
  def show
    @playlist = Playlist.find(params[:playlist_id])
  end
end