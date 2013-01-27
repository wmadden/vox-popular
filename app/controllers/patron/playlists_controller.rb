class Patron::PlaylistsController < PatronController

  def show
    @playlist = Playlist.find(params[:id])
    @unvoted_placements = @playlist.placements.includes(:votes).select do |pm|
      puts "pm.id = #{pm.id.inspect}"
      puts "pm.votes = #{pm.votes.inspect}"
      pm.votes.where(patron_id: @patron.id).count == 0
    end
  end

end