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
  include Groupable
  belongs_to :season
  has_many :matchups, dependent: :destroy
  has_many :teams, through: :matchups
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :season_id}, length: {in: 2..255}
  validates :location, presence: true
  acts_as_gmappable process_geocoding: :geocode?, address: "location", normalized_address: "location", msg: "Google doesn't know where that is."

  scope :future, -> { where("start > ?", Time.zone.now)}

  def geocode?
    (!location.blank? && (latitude.blank? || longitude.blank?)) || location_changed?
  end

  def organization
    self.season.organization
  end

end
