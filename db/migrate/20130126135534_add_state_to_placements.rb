class AddStateToPlacements < ActiveRecord::Migration
  def change
    add_column :playlists, :state, :string
  end
end
