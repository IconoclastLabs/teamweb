class MoveTeamsUnderSeasons < ActiveRecord::Migration
  def change
    #remove old
    remove_column :teams, :event_id

    # Add the new
    add_column :teams, :season_id, :integer
    add_index :teams, :season_id
  end
end
