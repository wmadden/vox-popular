class Patron::PlaylistsController < PatronController

  def show
    @playlist = Playlist.find(params[:playlist_id])
  end

end