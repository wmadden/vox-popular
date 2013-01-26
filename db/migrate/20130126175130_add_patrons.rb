class AddPatrons < ActiveRecord::Migration
  def change
    create_table :patrons do |t|
      t.timestamps
    end
  end
end