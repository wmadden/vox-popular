class Playlist < ActiveRecord::Base

  has_many :placements
  belongs_to :now_playing, :class_name => 'Placement'

  def progress
    self.now_playing = up_next.first
    save!
  end

  def unvoted_placements(patron)
    placements.includes(:votes).select do |pm|
      pm.votes.where(patron_id: patron.id).count == 0
    end
  end

  def up_next
    unplayed_placements = placements.where(:state => :unplayed) - [now_playing]
    unplayed = unplayed_placements.sort_by { |placement| placement.vote_sum }.reverse
    unplayed.first(4)
  end

end