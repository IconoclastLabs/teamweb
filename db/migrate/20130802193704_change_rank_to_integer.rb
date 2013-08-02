class ChangeRankToInteger < ActiveRecord::Migration
  def change
    change_column :teams, :rank, :integer
  end
end
