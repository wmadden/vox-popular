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
    vote = Placement.find(params[:id]).votes.new
    vote.patron = Patron.find(session[:patron_id])
    vote.value = 1

    vote.save!

    render nothing: true
  end

  def dismiss
    vote = Placement.find(params[:id]).votes.new
    vote.patron = Patron.find(session[:patron_id])
    vote.value = 0

    vote.save!

    render nothing: true
  end

end