class AddFinishedPlayingAtToPlacements < ActiveRecord::Migration
  def change
    add_column :placements, :finished_playing_at, :datetime
  end
end
