class Placement < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :track

  has_many :votes

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

    end

  end

end