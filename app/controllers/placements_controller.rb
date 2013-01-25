class PlacementsController

  def create

    placement = Playlist.find(params[:playlist_id]).placements.new(params[:placement])

    placement.save!

  end

end