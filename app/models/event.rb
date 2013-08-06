# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  about           :string(255)
#  organization_id :integer
#  location        :string(255)
#  start           :date
#  end             :date
#  created_at      :datetime
#  updated_at      :datetime
#  latitude        :float
#  longitude       :float
#  gmaps           :boolean
#  max_members     :integer
#

class Event < ActiveRecord::Base
  belongs_to :organization
  has_many :teams, dependent: :destroy
  has_many :members, dependent: :destroy, as: :groupable
  has_many :users, through: :members
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :organization_id}
  acts_as_gmappable process_geocoding: :geocode?, address: "location", normalized_address: "location", msg: "Google doesn't know where that is."

  scope :future, -> { where("start > ?", Time.zone.now)}

  def geocode?
    (!location.blank? && (latitude.blank? || longitude.blank?)) || location_changed?
  end

  def add_event_member(user, admin_flag: false)
    Member.transaction do
      self.members.add_member(user, admin_flag: admin_flag)
      should_raise = self.max_members && self.members.size > self.max_members
      raise ActiveRecord::Rollback, "Max members met" if should_raise
      true
    end # end Transaction
  end

end
