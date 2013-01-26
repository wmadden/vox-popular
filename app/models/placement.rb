class Placement < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :track

  has_many :votes

  attr_accessible :finished_playing_at

end