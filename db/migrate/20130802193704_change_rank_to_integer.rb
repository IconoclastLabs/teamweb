class ChangeRankToInteger < ActiveRecord::Migration
  def change
    # from some strange commit on some strange planet this is in some DBs
    add_column :teams, :rank, :decimal
    # fix for the previous
    change_column :teams, :rank, :integer
  end
end
