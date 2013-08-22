# == Schema Information
#
# Table name: seasons
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  name            :string(255)      not null
#  start           :date
#  end             :date
#  members_allowed :boolean          default(TRUE), not null
#  max_members     :integer
#  teams_allowed   :boolean          default(TRUE), not null
#  max_teams       :integer
#  max_team_size   :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Season < ActiveRecord::Base
  include Groupable
  belongs_to :organization
  has_many :events, dependent: :destroy
  has_many :teams, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :organization_id}, length: {in: 2..40}
  validates_numericality_of :max_team_size, allow_nil: true, greater_than: 0
  validates_numericality_of :max_teams, allow_nil: true, greater_than: 0, if: -> {self.teams_allowed?}
  validates_numericality_of :max_members, allow_nil: true, greater_than: 0, if: -> {self.members_allowed?}  
end
