class AddStateToPlacements < ActiveRecord::Migration
  def change
    add_column :placement, :state, :string
  end
end
