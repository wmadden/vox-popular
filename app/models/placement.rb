class Placement < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :track

  has_many :votes

  accepts_nested_attributes_for :track
  attr_accessible :track_attributes

  state_machine :state, :initial=> :unplayed do

    after_transition :on => :stop_playing, :do => :progress_playlist

    state :unplayed do

    end

    state :played do

    end

    state :playing do

    end

    event :stop_playing do
      transition  :playing => :played
    end

    event :start_playing do
      transition :unplayed => :playing
    end

    def initialize
      super()
    end

    def progress_playlist
      playlist.progress
    end

  end

  def vote_sum
    result = 0
    votes.each do |vote|
      result += vote.value
    end

    result
  end

end