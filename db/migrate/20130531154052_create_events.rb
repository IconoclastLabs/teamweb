class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :about
      t.references :coordinator
      t.string :location
      t.date :start
      t.date :end

      t.timestamps
    end
    add_index :events, :coordinator_id
  end
end
