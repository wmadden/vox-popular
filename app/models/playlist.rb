class Playlist < ActiveRecord::Base

  has_many :placements

  def currently_playing

  end

  def next

  end

end