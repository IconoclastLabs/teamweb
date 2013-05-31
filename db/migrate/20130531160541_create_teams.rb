class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.references :event

      t.timestamps
    end
    add_index :teams, :event_id
  end
end
