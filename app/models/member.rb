# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  organization_id :integer
#  event_id        :integer
#  team_id         :integer
#  admin           :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  belongs_to :event
  belongs_to :team

  # filters for admins that are true 
  #   e.g. Team.first.members.admins
  scope :admins, -> { where(admin: true) }
  # filters for all members of the given event in teams
  #   e.g. Member.event_team_members(Event.first)
  scope :event_team_members, ->(event) { where(team_id: event.teams)}

  def self.add_admin user
    self.create(user_id: user.id, admin: true)
  end
end
