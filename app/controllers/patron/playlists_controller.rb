class Patron::PlaylistsController < PatronController

  def show
    @playlist = Playlist.find(params[:id])
    @unvoted_placements = @playlist.unvoted_placements(@patron)
    @upcoming_placements = @playlist.up_next
  end

end