# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  about                :string(255)
#  coordinator_group_id :integer
#  location             :string(255)
#  start                :date
#  end                  :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  latitude             :float
#  longitude            :float
#  gmaps                :boolean
#

class Event < ActiveRecord::Base
  belongs_to :coordinator_group
  has_many :teams, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :coordinator_group_id}
  acts_as_gmappable

  def gmaps4rails_address
    "#{self.location}"
  end

end
