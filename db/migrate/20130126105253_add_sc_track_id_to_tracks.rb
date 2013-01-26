class AddScTrackIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :sc_track_id, :string
  end
end