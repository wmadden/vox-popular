class Placement < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :tracks

end