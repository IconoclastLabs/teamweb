# == Schema Information
#
# Table name: matchups
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  team_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Matchup < ActiveRecord::Base
  belongs_to :event
  belongs_to :team
end
