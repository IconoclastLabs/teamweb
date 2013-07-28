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
#

class Event < ActiveRecord::Base
  belongs_to :organization
  has_many :teams, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :organization_id}
  acts_as_gmappable process_geocoding: :geocode?, address: "location", normalized_address: "location", msg: "Google doesn't know where that is."

  # def gmaps4rails_address
  #   "#{self.location}"
  # end

  def geocode?
    (!location.blank? && (latitude.blank? || longitude.blank?)) || location_changed?
  end

end
