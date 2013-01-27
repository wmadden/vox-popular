class Playlist < ActiveRecord::Base

  has_many :placements
  belongs_to :now_playing, :class_name => 'Placement'

  def progress

    unplayed_placements = placements.where(:state => :unplayed)
    unplayed_placements = unplayed_placements.sort_by {|placement| placement.vote_sum}
    unplayed_track = unplayed_placements.first

    self.now_playing = unplayed_track
    save!

  end

  def up_next

    unplayed = unplayed_placements.sort_by {|placement| placement.vote_sum}
    unplayed.first(4)

  end

end