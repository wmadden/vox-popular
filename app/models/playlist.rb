class Playlist < ActiveRecord::Base

  has_many :placements
  belongs_to :now_playing, :class_name => 'Placement'

  def progress

    unplayed_track = placements.where(:state => :unplayed).sample
    self.now_playing = unplayed_track
    save!

  end

end