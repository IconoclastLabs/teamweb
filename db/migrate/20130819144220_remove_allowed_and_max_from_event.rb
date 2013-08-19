class RemoveAllowedAndMaxFromEvent < ActiveRecord::Migration
  def change
    # remove the old
    remove_column :events, :teams_allowed
    remove_column :events, :events_allowed
    remove_column :events, :max_members
    remove_column :events, :max_teams
    remove_column :events, :max_team_size

    # Add the new
    add_column :events, :season_id, :integer
    add_index :events, :season_id
  end
end
