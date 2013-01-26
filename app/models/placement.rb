class Placement < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :track

  has_many :votes

end