class AddPlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.timestamps
    end
  end
end