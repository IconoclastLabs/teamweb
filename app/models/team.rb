# == Schema Information
#
# Table name: teams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  event_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rank        :integer
#  max_members :integer
#

class Team < ActiveRecord::Base
  belongs_to :event
  has_many :members, dependent: :destroy, as: :groupable
  has_many :users, through: :members
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :event_id}
  # if max_members then greater than 0
  validates_numericality_of :max_members, allow_nil: true, greater_than: 0
  validate :owner_allows_teams
  validate :event_limits

  def add_team_member(user, admin_flag: false)
    Member.transaction do
      self.members.add_member(user, admin_flag: admin_flag)
      should_raise = self.max_members && self.members.size > self.max_members
      raise ActiveRecord::Rollback, "Max team members met" if should_raise
      true
    end # end Transaction
  end

  def owner_allows_teams
    if self.event.try(:teams_allowed?) == false # nil not false
      errors.add(:event, "Teams are not allowed")
    end
  end

  def event_limits
    
    if self.event.try(:max_team_size) && self.max_members
      errors.add(:team, "members may not exceed event limits") if self.max_members > self.event.max_team_size
    end

  end
end
