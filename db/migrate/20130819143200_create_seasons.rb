class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.references :organization, index: true
      t.string :name, null: false
      t.date :start
      t.date :end
      t.boolean :members_allowed, default: true, null: false
      t.integer :max_members
      t.boolean :teams_allowed, default: true, null: false
      t.integer :max_teams
      t.integer :max_team_size

      t.timestamps
    end
  end
end
