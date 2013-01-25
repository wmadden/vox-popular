class Track < ActiveRecord::Base
  has_many :placements
end