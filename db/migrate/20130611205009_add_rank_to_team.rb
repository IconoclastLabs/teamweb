class AddRankToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :rank, :number
  end
end
