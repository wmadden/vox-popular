class Vote < ActiveRecord::Base

  belongs_to :patron
  belongs_to :placement

  attr_accessible :value

end