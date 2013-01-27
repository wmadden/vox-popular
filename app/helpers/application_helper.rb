module ApplicationHelper
  def render_placement(placement, playlist)
    {
        soundcloud_track_id: placement.track.sc_track_id,
        id:                  placement.id,
        playlist_id:         playlist.id,
        score:               placement.vote_sum
    }
  end
end
