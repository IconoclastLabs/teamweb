class RenameCoordinatorsTableCoordinatorGroups < ActiveRecord::Migration
  def change
    rename_table :coordinators, :coordinator_groups
    # adjust id field
    rename_column :events, :coordinator_id, :coordinator_group_id
  end
end
