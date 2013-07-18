class RenameCoordinatorGroupsTableOrganization < ActiveRecord::Migration
  def change
  	rename_table :coordinator_groups, :organizations
    # adjust id field
    rename_column :events, :coordinator_group_id, :organization_id
  end
end
