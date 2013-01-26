class AddTimestampToPlaylists < ActiveRecord::Migration
  def change_table
    add_column(:placements, :created_at, :datetime)
    add_column(:placements, :updated_at, :datetime)
  end
end
