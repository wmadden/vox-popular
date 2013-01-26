class Playlist < ActiveRecord::Base

  has_many :placements
  belongs_to :now_playing, :class_name => :placement

end