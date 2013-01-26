class AddStateToPlacements < ActiveRecord::Migration
  def change
    add_column :placements, :state, :string
  end
end
