class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :placement_id
      t.integer :patron_id

      t.timestamps
    end
  end
end
