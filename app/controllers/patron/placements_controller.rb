class Patron::PlacementsController < PatronController

  def new
    @playlist = Playlist.find(params[:playlist_id])
    @placement = @playlist.placements.new
  end

  def create
    placement = Playlist.find(params[:playlist_id]).placements.new(params[:placement])
    placement.save!
  end

  def upvote
    vote = Placement.find(params[:id]).vote.new
    vote.patron = Patron.find(session[:patron_id])
    vote.value = 1

    vote.save!

    #should remove from list

  end

  def dismiss
    vote = Placement.find(params[:id]).vote.new
    vote.patron = Patron.find(session[:patron_id])
    vote.value = 0

    vote.save!

    #should remove from list

  end

end