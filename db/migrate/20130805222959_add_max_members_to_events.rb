class AddMaxMembersToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_members, :integer
  end
end
