class Track < ActiveRecord::Base
  has_many :placements

  attr_accessible :sc_track_id

end