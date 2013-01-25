class AddPlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.integer :playlist_id
      t.integer :track_id
    end
  end
end
