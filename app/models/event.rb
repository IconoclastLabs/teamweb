# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  about          :string(255)
#  coordinator_id :integer
#  location       :string(255)
#  start          :date
#  end            :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :coordinator
  has_many :teams
  validates :name, presence: true
end
