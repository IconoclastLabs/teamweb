class AddMaxTeamsAndMaxTeamSizeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_teams, :integer
    add_column :events, :max_team_size, :integer
  end
end
