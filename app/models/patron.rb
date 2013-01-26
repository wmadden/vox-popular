class Patron < ActiveRecord::Base

  has_many :votes
  has_many :placements

end