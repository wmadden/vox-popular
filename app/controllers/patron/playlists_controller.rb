class Patron::PlaylistsController < PatronController

  def show
    @playlist = Playlist.find(params[:id])
    @unvoted_placements = @playlist.placements.select do |pm|
      pm.votes.where(patron_id: @patron.id).count == 0
    end
  end

end