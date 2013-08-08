class AddMemberAndTeamsBooleansToEvents < ActiveRecord::Migration
  def change
    add_column :events, :members_allowed, :boolean, default: true
    add_column :events, :teams_allowed, :boolean, default: true
  end
end
