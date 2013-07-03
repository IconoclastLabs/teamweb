# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rank       :decimal(, )
#

class Team < ActiveRecord::Base
  belongs_to :event
  #attr_accessible :name
end
