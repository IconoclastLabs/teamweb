class AddMaxmembersToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :max_members, :integer
  end
end
