class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.references :event, index: true
      t.references :team, index: true

      t.timestamps
    end
  end
end
