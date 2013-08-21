class RemoveOldInexFromEvents < ActiveRecord::Migration
  def change
    # forgot to remove this
    remove_column :events, :organization_id
  end
end
