class Patron::PlacementsController < PatronController

  def new
    @playlist = Playlist.find(params[:playlist_id])
    @placement = Placement.new
  end

  def create
    placement = Playlist.find(params[:playlist_id]).placements.new(params[:placement])
    placement.save!
  end

end