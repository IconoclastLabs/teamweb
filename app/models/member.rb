# == Schema Information
#
# Table name: members
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  admin          :boolean
#  created_at     :datetime
#  updated_at     :datetime
#  groupable_id   :integer
#  groupable_type :string(255)
#

class Member < ActiveRecord::Base
  belongs_to :user
  # Polymorphic since it may belong to team, event, or organization
  # parent accessible via self.groupable
  belongs_to :groupable, polymorphic: true

  # filters for admins that are true 
  #   e.g. Team.first.members.admins
  scope :admins, -> { where(admin: true) }
  # filters for all members of the given event in teams
  #   e.g. Member.event_team_members(Event.first)
  scope :event_team_members, ->(event) { where(groupable_id: event.teams, groupable_type: "Team")}

  def self.add_member (user, admin_flag: false)
    self.where(user_id: user.id).first_or_create(admin: admin_flag)
  end
end
