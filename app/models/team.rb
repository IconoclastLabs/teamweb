# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  belongs_to :event
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :event_id}
end
