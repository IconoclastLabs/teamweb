class Coordinator < ActiveRecord::Base
  attr_accessible :about, :contact, :location, :name
  has_many :events
  validates :name, presence: true
end
