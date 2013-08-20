# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  about      :string(255)
#  location   :string(255)
#  start      :date
#  end        :date
#  created_at :datetime
#  updated_at :datetime
#  latitude   :float
#  longitude  :float
#  gmaps      :boolean
#  season_id  :integer
#

class Event < ActiveRecord::Base
  belongs_to :season
  has_many :members, dependent: :destroy, as: :groupable
  has_many :users, through: :members
  has_many :matchups, dependent: :destroy
  has_many :teams, through: :matchups
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :season_id}, length: {in: 2..255}
  validates :location, presence: true
  acts_as_gmappable process_geocoding: :geocode?, address: "location", normalized_address: "location", msg: "Google doesn't know where that is."
  #validates_numericality_of :max_team_size, allow_nil: true, greater_than: 0
  #validates_numericality_of :max_teams, allow_nil: true, greater_than: 0, if: -> {self.teams_allowed?}
  #validates_numericality_of :max_members, allow_nil: true, greater_than: 0, if: -> {self.members_allowed?}

  scope :future, -> { where("start > ?", Time.zone.now)}

  def geocode?
    (!location.blank? && (latitude.blank? || longitude.blank?)) || location_changed?
  end

  def add_event_member(user, admin_flag: false)
    Member.transaction do
      self.members.add_member(user, admin_flag: admin_flag)
      #should_raise = self.max_members && self.members.size > self.max_members
      raise ActiveRecord::Rollback, "Max members met" if should_raise
      true
    end # end Transaction
  end

  def organization
    self.season.organization
  end

end
