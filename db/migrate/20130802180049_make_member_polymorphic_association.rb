class MakeMemberPolymorphicAssociation < ActiveRecord::Migration
  def change
    # remove the old
    remove_column :members, :organization_id
    remove_column :members, :event_id
    remove_column :members, :team_id
    
    # following two lines equal to create table where
    # t.references :groupable, polymorphic: true
    add_column :members, :groupable_id, :integer
    add_column :members, :groupable_type, :string
  end
end
