class AddNowPlayingToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :now_playing_id, :integer
  end
end